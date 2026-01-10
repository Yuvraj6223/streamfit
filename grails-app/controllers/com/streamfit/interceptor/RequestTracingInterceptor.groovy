package com.streamfit.interceptor

import org.slf4j.MDC

/**
 * Request Tracing Interceptor - Adds correlation ID to all requests
 * for distributed tracing and debugging
 */
class RequestTracingInterceptor {

    int order = HIGHEST_PRECEDENCE  // Run first before all other interceptors
    
    RequestTracingInterceptor() {
        matchAll()
    }

    boolean before() {
        // Generate or reuse correlation ID
        String correlationId = request.getHeader('X-Correlation-ID') ?: 
                               request.getHeader('X-Request-ID') ?: 
                               UUID.randomUUID().toString()
        
        // Store in MDC for logging
        MDC.put('correlationId', correlationId)
        MDC.put('requestPath', request.requestURI)
        MDC.put('requestMethod', request.method)
        
        // Store in request for controllers to access
        request.setAttribute('correlationId', correlationId)
        
        // Add to response header for client correlation
        response.setHeader('X-Correlation-ID', correlationId)
        
        // Log request start (debug level to avoid noise)
        log.debug "REQUEST_START: [${correlationId}] ${request.method} ${request.requestURI}"
        
        true
    }

    boolean after() {
        String correlationId = MDC.get('correlationId') ?: 'unknown'
        
        // Log request end with status
        log.debug "REQUEST_END: [${correlationId}] ${request.method} ${request.requestURI} -> ${response.status}"
        
        true
    }
    
    void afterView() {
        // Clean up MDC to prevent memory leaks
        MDC.remove('correlationId')
        MDC.remove('requestPath')
        MDC.remove('requestMethod')
    }
}
