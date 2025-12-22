<%@ page contentType="text/html;charset=UTF-8" %>
<%--
    SEO Meta Tags Template
    Include this in main.gsp or individual pages for comprehensive SEO optimization
    
    Usage in GSP pages:
    <g:set var="pageTitle" value="Your Page Title" />
    <g:set var="pageDescription" value="Your meta description" />
    <g:set var="pageKeywords" value="keyword1, keyword2, keyword3" />
    <g:set var="pageImage" value="${assetPath(src: 'og-image.png')}" />
    <g:set var="pageType" value="website" /> <!-- or "article" -->
--%>

<!-- Basic Meta Tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- SEO Meta Tags -->
<title>${pageTitle ?: 'LearnerDNA - Free Student Aptitude Test | Discover Your Learning DNA'}</title>
<meta name="description" content="${pageDescription ?: 'Discover your learning style, cognitive strengths & ideal career stream. Free aptitude test for students aged 14-20. No signup required. 10,000+ students tested.'}">
<meta name="keywords" content="${pageKeywords ?: 'student aptitude test, learning style test, career guidance, stream selection, cognitive assessment, free aptitude test India'}">
<meta name="author" content="LearnerDNA">
<meta name="robots" content="${pageRobots ?: 'index, follow'}">

<!-- Geographic Targeting -->
<meta name="geo.region" content="IN">
<meta name="geo.placename" content="India">
<meta name="geo.position" content="20.5937;78.9629">
<meta name="ICBM" content="20.5937, 78.9629">

<!-- Language -->
<meta http-equiv="content-language" content="en-IN">

<!-- Canonical URL -->
<g:set var="canonicalUrl" value="${pageCanonical ?: (request.scheme + '://' + request.serverName + request.forwardURI)}" />
<link rel="canonical" href="${canonicalUrl}">

<!-- Alternate Language Versions -->
<link rel="alternate" hreflang="en-IN" href="${canonicalUrl}">
<link rel="alternate" hreflang="en" href="${canonicalUrl}">
<link rel="alternate" hreflang="x-default" href="${canonicalUrl}">

<!-- Open Graph Meta Tags (Facebook, LinkedIn) -->
<meta property="og:type" content="${pageType ?: 'website'}">
<meta property="og:site_name" content="LearnerDNA">
<meta property="og:title" content="${pageTitle ?: 'LearnerDNA - Discover Your Learning DNA'}">
<meta property="og:description" content="${pageDescription ?: 'Free aptitude test for students. Discover your learning style and ideal career stream in 20 minutes.'}">
<meta property="og:url" content="${canonicalUrl}">
<meta property="og:locale" content="en_IN">
<meta property="og:locale:alternate" content="en_US">

<g:if test="${pageImage}">
    <meta property="og:image" content="${pageImage}">
    <meta property="og:image:secure_url" content="${pageImage}">
    <meta property="og:image:type" content="image/png">
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="630">
    <meta property="og:image:alt" content="${pageImageAlt ?: pageTitle}">
</g:if>
<g:else>
    <meta property="og:image" content="${request.scheme}://${request.serverName}${assetPath(src: 'og-default.png')}">
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="630">
</g:else>

<!-- Twitter Card Meta Tags -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:site" content="@learnerdna">
<meta name="twitter:creator" content="@learnerdna">
<meta name="twitter:title" content="${pageTitle ?: 'LearnerDNA - Discover Your Learning DNA'}">
<meta name="twitter:description" content="${pageDescription ?: 'Free aptitude test for students. Discover your learning style and ideal career stream.'}">
<g:if test="${pageImage}">
    <meta name="twitter:image" content="${pageImage}">
    <meta name="twitter:image:alt" content="${pageImageAlt ?: pageTitle}">
</g:if>
<g:else>
    <meta name="twitter:image" content="${request.scheme}://${request.serverName}${assetPath(src: 'og-default.png')}">
</g:else>

<!-- Additional Meta Tags for Mobile -->
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="default">
<meta name="apple-mobile-web-app-title" content="LearnerDNA">
<meta name="theme-color" content="#3A7CA5">

<!-- Favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="${assetPath(src: 'favicon-32x32.png')}">
<link rel="icon" type="image/png" sizes="16x16" href="${assetPath(src: 'favicon-16x16.png')}">
<link rel="apple-touch-icon" sizes="180x180" href="${assetPath(src: 'apple-touch-icon.png')}">

<!-- Preconnect to External Domains (Performance) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<!-- DNS Prefetch -->
<link rel="dns-prefetch" href="https://fonts.googleapis.com">
<link rel="dns-prefetch" href="https://fonts.gstatic.com">

<!-- Structured Data (JSON-LD) -->
<g:if test="${structuredData}">
    <script type="application/ld+json">
        ${raw(structuredData)}
    </script>
</g:if>

<!-- Default Organization Schema (if not overridden) -->
<g:if test="${!structuredData && pageType != 'article'}">
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "EducationalOrganization",
        "name": "LearnerDNA",
        "alternateName": "StreamFit",
        "url": "${request.scheme}://${request.serverName}",
        "logo": "${request.scheme}://${request.serverName}${assetPath(src: 'logo1.png')}",
        "description": "India's leading student diagnostic platform for learning style assessment and career guidance",
        "address": {
            "@type": "PostalAddress",
            "addressCountry": "IN"
        },
        "sameAs": [
            "https://twitter.com/learnerdna",
            "https://linkedin.com/company/learnerdna"
        ]
    }
    </script>
</g:if>

<!-- Breadcrumb Schema (if breadcrumbs provided) -->
<g:if test="${breadcrumbs}">
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "BreadcrumbList",
        "itemListElement": [
            <g:each in="${breadcrumbs}" var="crumb" status="i">
            {
                "@type": "ListItem",
                "position": ${i + 1},
                "name": "${crumb.name}",
                "item": "${crumb.url}"
            }<g:if test="${i < breadcrumbs.size() - 1}">,</g:if>
            </g:each>
        ]
    }
    </script>
</g:if>

<!-- Article Schema (for blog posts and guides) -->
<g:if test="${pageType == 'article' && articleData}">
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "Article",
        "headline": "${articleData.headline ?: pageTitle}",
        "description": "${articleData.description ?: pageDescription}",
        "image": "${articleData.image ?: pageImage}",
        "datePublished": "${articleData.datePublished}",
        "dateModified": "${articleData.dateModified ?: articleData.datePublished}",
        "author": {
            "@type": "Organization",
            "name": "LearnerDNA"
        },
        "publisher": {
            "@type": "Organization",
            "name": "LearnerDNA",
            "logo": {
                "@type": "ImageObject",
                "url": "${request.scheme}://${request.serverName}${assetPath(src: 'logo1.png')}"
            }
        }
    }
    </script>
</g:if>

<!-- Performance Hints -->
<g:if test="${preloadImages}">
    <g:each in="${preloadImages}" var="img">
        <link rel="preload" as="image" href="${img}">
    </g:each>
</g:if>

<!-- Additional Custom Meta Tags -->
<g:if test="${customMetaTags}">
    ${raw(customMetaTags)}
</g:if>

