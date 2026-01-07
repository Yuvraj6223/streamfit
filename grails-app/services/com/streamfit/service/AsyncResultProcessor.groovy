package com.streamfit.service

import com.streamfit.UserSession
import com.streamfit.EngageData
import com.streamfit.GameQuestion
import com.streamfit.GameOption
import grails.gorm.transactions.Transactional
import org.springframework.stereotype.Service
import java.util.concurrent.CompletableFuture
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.ThreadPoolExecutor
import java.util.concurrent.TimeUnit
import java.util.concurrent.LinkedBlockingQueue
import java.util.concurrent.ThreadFactory

/**
 * High-performance async result processor for handling test submissions
 * Optimized for millions of concurrent users - Updated for new unified system
 */
@Service
class AsyncResultProcessor {
    
    // Thread pool for async processing
    private static final ExecutorService resultProcessorPool = Executors.newFixedThreadPool(
        Runtime.getRuntime().availableProcessors() * 2, // 2x CPU cores
        new ThreadFactory() {
            Thread newThread(Runnable r) {
                Thread t = new Thread(r, "AsyncResultProcessor-${System.currentTimeMillis()}")
                t.daemon = true
                return t
            }
        }
    )
    
    // Thread pool for reward processing (separate to avoid blocking results)
    private static final ExecutorService rewardProcessorPool = Executors.newFixedThreadPool(
        4, // Fixed small pool for rewards
        new ThreadFactory() {
            Thread newThread(Runnable r) {
                Thread t = new Thread(r, "RewardProcessor-${System.currentTimeMillis()}")
                t.daemon = true
                return t
            }
        }
    )
    
    DiagnosticService diagnosticService
    // RewardService rewardService // Disabled - reward system is no longer available
    
    /**
     * Fast submission - immediately returns sessionId and processes results in background
     * REDUCES: 1-3 seconds → 50-100ms response time
     */
    def submitTestAsync(String sessionId, List answers) {
        log.info "ASYNC_DEBUG: submitTestAsync called with sessionId: ${sessionId}, answers count: ${answers.size()}"
        answers.each { answer ->
            log.info "ASYNC_DEBUG: Answer - QuestionId: ${answer.questionId}, AnswerValue: ${answer.answerValue}"
        }
        
        try {
            // 1. Quick validation and session update (synchronous, fast)
            def session = UserSession.findBySessionId(sessionId)
            if (!session) {
                log.error "ASYNC_DEBUG: Session not found: ${sessionId}"
                return [success: false, error: 'Session not found']
            }
            
            log.info "ASYNC_DEBUG: Found session: ${session.sessionId}, status: ${session.status}"
            
            // 2. Mark as processing immediately (prevents duplicate submissions)
            session.status = 'PROCESSING'
            session.save(flush: false) // Don't flush - let background handle it
            
            log.info "ASYNC_DEBUG: Session marked as PROCESSING, starting async tasks"
            
            // 3. Save responses asynchronously (non-blocking)
            CompletableFuture.runAsync({
                saveResponsesAsync(session, answers)
            }, resultProcessorPool)
            
            // 4. Process results in background (non-blocking)
            CompletableFuture.runAsync({
                processResultsAsync(session)
            }, resultProcessorPool)
            
            // 5. Process rewards in separate background thread (non-blocking)
            CompletableFuture.runAsync({
                processRewardsAsync(session)
            }, rewardProcessorPool)
            
            // 6. IMMEDIATE RESPONSE - user gets redirected to results page
            def response = [
                success: true,
                sessionId: sessionId,
                processing: true,
                estimatedTime: '2-5 seconds' // Manage user expectations
            ]
            
            log.info "ASYNC_DEBUG: Returning immediate response: ${response}"
            return response
            
        } catch (Exception e) {
            log.error "ASYNC_DEBUG: Error in submitTestAsync: ${e.message}", e
            return [success: false, error: 'Submission failed: ' + e.message]
        }
    }
    
    /**
     * Save responses asynchronously with batch processing
     */
    private void saveResponsesAsync(UserSession session, List answers) {
        try {
            UserSession.withTransaction {
                // Batch delete existing responses
                EngageData.where { sessionId == session.sessionId }.deleteAll()
                
                // Batch insert new responses
                def responses = answers.collect { answer ->
                    def question = GameQuestion.findByQuestionId(answer.questionId)
                    log.info "SAVE_DEBUG: Found question: ${question?.questionId}, gameType: ${question?.gameType}"
                    
                    def selectedOption = GameOption.findByQuestionAndOptionValue(question, answer.answerValue?.toString())
                    log.info "SAVE_DEBUG: Looking for option with value: '${answer.answerValue}', found: ${selectedOption?.id}, optionText: ${selectedOption?.optionText}"
                    
                    if (!selectedOption) {
                        log.error "SAVE_DEBUG: NO OPTION FOUND for question ${answer.questionId} with answerValue '${answer.answerValue}'"
                        // Let's see all available options for this question
                        def allOptions = GameOption.findAllByQuestion(question)
                        log.error "SAVE_DEBUG: Available options for question ${answer.questionId}:"
                        allOptions.each { opt ->
                            log.error "SAVE_DEBUG: - Option ID: ${opt.id}, Value: '${opt.optionValue}', Text: ${opt.optionText}"
                        }
                    }
                    
                    new EngageData(
                        sessionId: session.sessionId,
                        gameType: question.gameType,
                        questionId: answer.questionId,
                        optionId: selectedOption?.id?.toString(),
                        timestamp: new Date(),
                        timeSpent: answer.timeSpent ?: 0,
                        confidenceLevel: answer.confidenceLevel,
                        isCorrect: selectedOption?.isCorrect
                    )
                }
                
                // Save all responses in one batch
                def validResponses = responses.findAll { it.optionId != null }
                if (validResponses) {
                    validResponses*.save(flush: false)
                }
                
                log.debug "Saved ${validResponses.size()} valid responses for session ${session.sessionId}"
            }
        } catch (Exception e) {
            log.error "Error saving responses async: ${e.message}", e
        }
    }
    
    /**
     * Process results asynchronously
     */
    private void processResultsAsync(UserSession session) {
        try {
            // Calculate results using the unified persona service
            def results = diagnosticService.unifiedPersonaService.calculateFinalPersona(session.sessionId)
            
            // Update session with results
            UserSession.withTransaction {
                def sessionToUpdate = UserSession.get(session.id)
                sessionToUpdate.status = 'COMPLETED'
                sessionToUpdate.endTime = new Date()
                // CRITICAL FIX: Extract the nested 'gameResults' map and save it.
                // This ensures the JSON structure matches what the dashboard controller expects.
                if (results && results.gameResults) {
                    sessionToUpdate.gameResults = new groovy.json.JsonBuilder(results.gameResults).toString()
                }
                sessionToUpdate.save(flush: true) // Flush here to commit results
            }
            
            log.info "Completed result processing for session ${session.sessionId} in ${(System.currentTimeMillis() - session.startTime.time)}ms"
            
        } catch (Exception e) {
            log.error "Error processing results async: ${e.message}", e
            // Mark as failed
            UserSession.withTransaction {
                def sessionToUpdate = UserSession.get(session.id)
                sessionToUpdate.status = 'FAILED'
                sessionToUpdate.save(flush: false)
            }
        }
    }
    
    /**
     * Process rewards asynchronously (separate thread pool)
     */
    private void processRewardsAsync(UserSession session) {
        try {
            // Wait a bit for results to be processed
            Thread.sleep(1000)
            
            def sessionWithResults = UserSession.findBySessionId(session.sessionId)
            if (sessionWithResults?.status == 'COMPLETED') {
                // Skip reward processing - reward system is disabled
                log.debug "Skipped reward processing for session ${session.sessionId} - reward system disabled"
            }
        } catch (Exception e) {
            log.error "Error processing rewards async: ${e.message}", e
        }
    }
    
    /**
     * Check if results are ready for a session
     */
    def getResultStatus(String sessionId) {
        try {
            def session = UserSession.findBySessionId(sessionId)
            if (!session) {
                return [found: false]
            }
            
            return [
                found: true,
                status: session.status,
                completed: session.status == 'COMPLETED',
                processing: session.status == 'PROCESSING',
                failed: session.status == 'FAILED'
            ]
        } catch (Exception e) {
            log.error "Error checking result status: ${e.message}", e
            return [found: false, error: 'Status check failed']
        }
    }
    
    /**
     * Get results if ready, return processing status if not
     */
    def getResultsIfReady(String sessionId) {
        def status = getResultStatus(sessionId)
        
        if (!status.found) {
            return [success: false, error: 'Session not found']
        }
        
        if (status.processing) {
            return [success: false, processing: true, message: 'Results are being calculated']
        }
        
        if (status.failed) {
            return [success: false, error: 'Result processing failed']
        }
        
        if (status.completed) {
            return diagnosticService.getResults(sessionId)
        }
        
        return [success: false, processing: true, message: 'Results not ready']
    }
    
    /**
     * Cleanup method for graceful shutdown
     */
    def shutdown() {
        resultProcessorPool.shutdown()
        rewardProcessorPool.shutdown()
        
        if (!resultProcessorPool.awaitTermination(30, TimeUnit.SECONDS)) {
            resultProcessorPool.shutdownNow()
        }
        
        if (!rewardProcessorPool.awaitTermination(30, TimeUnit.SECONDS)) {
            rewardProcessorPool.shutdownNow()
        }
    }
}
