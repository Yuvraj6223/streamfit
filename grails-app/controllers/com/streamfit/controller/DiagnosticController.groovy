package com.streamfit.controller

import com.streamfit.GameQuestion
import com.streamfit.GameOption
import com.streamfit.GameDataMigration
import grails.converters.JSON
import grails.gorm.transactions.Transactional
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.beans.factory.annotation.Autowired

class DiagnosticController {
    
    @Autowired
    RedisTemplate<String, Object> redisTemplate
    
    /**
     * Check PERSONALITY game data
     * GET /diagnostic/personality-check
     */
    def personalityCheck() {
        def result = [:]
        
        try {
            // Check if PERSONALITY questions exist
            def questions = GameQuestion.findAllByGameType('PERSONALITY')
            result.questionsFound = questions.size()
            result.questions = questions.collect { q ->
                def options = GameOption.findAllByQuestion(q)
                [
                    questionId: q.questionId,
                    questionText: q.questionText,
                    questionType: q.questionType,
                    optionsCount: options.size(),
                    options: options.collect { opt ->
                        [
                            id: opt.id,
                            text: opt.optionText,
                            value: opt.optionValue
                        ]
                    }
                ]
            }
            
            result.success = true
            result.message = "Found ${questions.size()} PERSONALITY questions"
            
        } catch (Exception e) {
            result.success = false
            result.error = e.message
            result.stackTrace = e.stackTrace.take(5).collect { it.toString() }
        }
        
        render(result as JSON)
    }
    
    /**
     * Clear PERSONALITY cache
     * POST /diagnostic/personality-clear-cache
     */
    def personalityClearCache() {
        def result = [:]
        
        try {
            // Clear all PERSONALITY-related cache keys
            def keysCleared = 0
            
            // Clear questions cache
            def questionsCacheKey = "v1:game:PERSONALITY:questions"
            if (redisTemplate.delete(questionsCacheKey)) {
                keysCleared++
            }
            
            // Clear test metadata cache
            def testCacheKey = "v1:game:PERSONALITY"
            if (redisTemplate.delete(testCacheKey)) {
                keysCleared++
            }
            
            // Clear all games cache
            def allGamesCacheKey = "v1:game:all"
            if (redisTemplate.delete(allGamesCacheKey)) {
                keysCleared++
            }
            
            result.success = true
            result.keysCleared = keysCleared
            result.message = "Cleared ${keysCleared} cache keys for PERSONALITY game"
            
        } catch (Exception e) {
            result.success = false
            result.error = e.message
            result.stackTrace = e.stackTrace.take(5).collect { it.toString() }
        }
        
        render(result as JSON)
    }
    
    /**
     * Re-run PERSONALITY migration
     * POST /diagnostic/personality-migrate
     */
    @Transactional
    def personalityMigrate() {
        def result = [:]
        
        try {
            // Check existing questions
            def existingQuestions = GameQuestion.findAllByGameType('PERSONALITY')
            result.existingQuestions = existingQuestions.size()
            
            if (existingQuestions.size() > 0) {
                result.success = false
                result.message = "PERSONALITY questions already exist. Delete them manually first if you want to recreate."
                result.questions = existingQuestions.collect { q ->
                    [questionId: q.questionId, questionText: q.questionText]
                }
                render(result as JSON)
                return
            }
            
            // Run migration
            def migration = new GameDataMigration()
            migration.migratePersonality()
            
            // Check results
            def questions = GameQuestion.findAllByGameType('PERSONALITY')
            result.questionsCreated = questions.size()
            result.success = true
            result.message = "Migration completed. Created ${questions.size()} questions"
            result.questions = questions.collect { q ->
                def options = GameOption.findAllByQuestion(q)
                [
                    questionId: q.questionId,
                    questionText: q.questionText,
                    optionsCount: options.size()
                ]
            }
            
        } catch (Exception e) {
            result.success = false
            result.error = e.message
            result.stackTrace = e.stackTrace.take(10).collect { it.toString() }
        }
        
        render(result as JSON)
    }
}
