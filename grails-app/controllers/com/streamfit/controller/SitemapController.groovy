package com.streamfit.controller

import grails.converters.XML

/**
 * Controller for generating XML sitemap for SEO
 */
class SitemapController {

    def diagnosticService

    /**
     * Generate XML sitemap
     * GET /sitemap.xml
     */
    def index() {
        response.contentType = "application/xml"
        response.characterEncoding = "UTF-8"
        
        def baseUrl = request.scheme + "://" + request.serverName
        if (request.serverPort != 80 && request.serverPort != 443) {
            baseUrl += ":" + request.serverPort
        }
        
        def urls = []
        
        // Homepage - Highest priority
        urls << [
            loc: baseUrl + "/",
            changefreq: "weekly",
            priority: "1.0",
            lastmod: formatDate(new Date())
        ]
        
        // Main navigation pages
        urls << [
            loc: baseUrl + "/about",
            changefreq: "monthly",
            priority: "0.5",
            lastmod: formatDate(new Date())
        ]
        
        urls << [
            loc: baseUrl + "/faq",
            changefreq: "monthly",
            priority: "0.6",
            lastmod: formatDate(new Date())
        ]
        
        // Personality test pages
        urls << [
            loc: baseUrl + "/personality",
            changefreq: "monthly",
            priority: "0.8",
            lastmod: formatDate(new Date())
        ]
        
        urls << [
            loc: baseUrl + "/personality/start",
            changefreq: "monthly",
            priority: "0.9",
            lastmod: formatDate(new Date())
        ]
        
        urls << [
            loc: baseUrl + "/personality/types",
            changefreq: "monthly",
            priority: "0.8",
            lastmod: formatDate(new Date())
        ]
        
        // Result tests hub
        urls << [
            loc: baseUrl + "/result",
            changefreq: "weekly",
            priority: "0.9",
            lastmod: formatDate(new Date())
        ]
        
        // Individual result test pages
        def tests = diagnosticService.getAvailableTests()
        tests.each { test ->
            urls << [
                loc: baseUrl + "/result/test/" + test.testId,
                changefreq: "monthly",
                priority: "0.8",
                lastmod: formatDate(test.lastUpdated ?: test.dateCreated)
            ]
        }
        
        // Render XML
        render(contentType: "application/xml") {
            urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") {
                urls.each { urlData ->
                    url {
                        loc(urlData.loc)
                        lastmod(urlData.lastmod)
                        changefreq(urlData.changefreq)
                        priority(urlData.priority)
                    }
                }
            }
        }
    }
    
    /**
     * Generate robots.txt
     * GET /robots.txt
     */
    def robots() {
        response.contentType = "text/plain"
        response.characterEncoding = "UTF-8"
        
        def baseUrl = request.scheme + "://" + request.serverName
        if (request.serverPort != 80 && request.serverPort != 443) {
            baseUrl += ":" + request.serverPort
        }
        
        render(text: """User-agent: *
Allow: /
Disallow: /api/
Disallow: /my-results/
Disallow: /admin/
Disallow: /login
Disallow: /signup
Disallow: /register
Disallow: /profile

# Allow important pages
Allow: /result/
Allow: /personality/
Allow: /about
Allow: /faq

# Sitemap
Sitemap: ${baseUrl}/sitemap.xml

# Crawl-delay for politeness
Crawl-delay: 1
""")
    }
    
    /**
     * Format date for sitemap (W3C Datetime format)
     */
    private String formatDate(Date date) {
        if (!date) {
            date = new Date()
        }
        def formatter = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX")
        return formatter.format(date)
    }
}

