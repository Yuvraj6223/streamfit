<%@ page contentType="text/html;charset=UTF-8" %>
<%--
    Structured Data (JSON-LD) Examples for LearnerDNA
    
    These schemas should be included in the appropriate pages to enhance SEO
    and enable rich snippets in search results.
    
    Usage: Copy the relevant schema to your GSP page and customize the values
--%>

<%-- ========================================
     1. ORGANIZATION SCHEMA (Homepage)
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "EducationalOrganization",
    "name": "LearnerDNA",
    "alternateName": "StreamFit",
    "url": "https://learnerdna.com",
    "logo": "https://learnerdna.com/assets/logo1.png",
    "description": "India's leading student diagnostic platform for learning style assessment and career guidance. Free aptitude tests for students aged 14-20.",
    "foundingDate": "2024",
    "address": {
        "@type": "PostalAddress",
        "addressCountry": "IN"
    },
    "contactPoint": {
        "@type": "ContactPoint",
        "contactType": "Customer Support",
        "email": "support@learnerdna.com",
        "availableLanguage": ["English", "Hindi"]
    },
    "sameAs": [
        "https://twitter.com/learnerdna",
        "https://linkedin.com/company/learnerdna",
        "https://facebook.com/learnerdna",
        "https://instagram.com/learnerdna"
    ]
}
</script>

<%-- ========================================
     2. QUIZ SCHEMA (Test Pages)
     Example: Exam Spirit Animal Test
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Quiz",
    "name": "Exam Spirit Animal Test",
    "description": "Discover your exam personality and learning style through our scientifically-designed diagnostic test. Find out if you're an Owl, Cheetah, Elephant, or Dolphin learner.",
    "educationalLevel": "Secondary Education",
    "educationalUse": "Assessment",
    "learningResourceType": "Assessment",
    "assesses": "Learning Style, Exam Strategy, Study Behavior",
    "numberOfQuestions": 12,
    "timeRequired": "PT5M",
    "inLanguage": "en-IN",
    "isAccessibleForFree": true,
    "hasPart": [
        {
            "@type": "Question",
            "eduQuestionType": "Multiple choice",
            "text": "How do you typically approach a new chapter?"
        }
    ],
    "provider": {
        "@type": "EducationalOrganization",
        "name": "LearnerDNA",
        "url": "https://learnerdna.com"
    },
    "offers": {
        "@type": "Offer",
        "price": "0",
        "priceCurrency": "INR",
        "availability": "https://schema.org/InStock"
    }
}
</script>

<%-- ========================================
     3. FAQ SCHEMA (FAQ Page)
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {
            "@type": "Question",
            "name": "Is this scientifically validated?",
            "acceptedAnswer": {
                "@type": "Answer",
                "text": "Our assessments are based on established cognitive psychology principles and have been tested with over 10,000 students with 89% reporting accurate matches. We use validated frameworks like VARK learning styles and cognitive load theory."
            }
        },
        {
            "@type": "Question",
            "name": "How long does the test take?",
            "acceptedAnswer": {
                "@type": "Answer",
                "text": "The complete Learning DNA assessment takes approximately 20 minutes. Individual diagnostic tests range from 5 to 10 minutes each. You can take tests at your own pace and return anytime."
            }
        },
        {
            "@type": "Question",
            "name": "Is it really free? No hidden costs?",
            "acceptedAnswer": {
                "@type": "Answer",
                "text": "Yes, all our diagnostic tests are 100% free with no hidden costs. You get instant results, personalized insights, and shareable reports without any payment. We may offer premium features in the future, but core tests will always remain free."
            }
        },
        {
            "@type": "Question",
            "name": "Do I need to sign up or create an account?",
            "acceptedAnswer": {
                "@type": "Answer",
                "text": "No signup required to take tests and view results. You can start immediately. However, creating a free account allows you to save your results, track progress, and access your dashboard anytime."
            }
        },
        {
            "@type": "Question",
            "name": "How accurate are the results?",
            "acceptedAnswer": {
                "@type": "Answer",
                "text": "Based on feedback from 10,000+ students, 89% reported that their results accurately matched their learning style and strengths. Our tests use scientifically-validated methodologies and are continuously refined based on user data."
            }
        }
    ]
}
</script>

<%-- ========================================
     4. ARTICLE SCHEMA (Archetype Pages)
     Example: The Owl Archetype
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Article",
    "headline": "The Owl - Methodical Learner Profile",
    "alternativeHeadline": "Complete Guide to the Owl Learning Archetype",
    "description": "Discover the strengths, study strategies, and ideal career streams for Owl learners - methodical, detail-oriented students who excel with structured preparation.",
    "image": "https://learnerdna.com/assets/archetypes/owl.png",
    "author": {
        "@type": "Organization",
        "name": "LearnerDNA"
    },
    "publisher": {
        "@type": "Organization",
        "name": "LearnerDNA",
        "logo": {
            "@type": "ImageObject",
            "url": "https://learnerdna.com/assets/logo1.png"
        }
    },
    "datePublished": "2025-01-01",
    "dateModified": "2025-01-15",
    "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": "https://learnerdna.com/archetypes/exam-spirit-animals/owl/"
    },
    "articleSection": "Learning Archetypes",
    "keywords": "owl learner, methodical learning style, detail-oriented student, structured study approach",
    "articleBody": "The Owl represents methodical, detail-oriented learners who excel with structured preparation..."
}
</script>

<%-- ========================================
     5. BREADCRUMB SCHEMA
     Example: Test Page Breadcrumb
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
        {
            "@type": "ListItem",
            "position": 1,
            "name": "Home",
            "item": "https://learnerdna.com/"
        },
        {
            "@type": "ListItem",
            "position": 2,
            "name": "Diagnostic Tests",
            "item": "https://learnerdna.com/diagnostic/"
        },
        {
            "@type": "ListItem",
            "position": 3,
            "name": "Exam Spirit Animal Test",
            "item": "https://learnerdna.com/diagnostic/test/SPIRIT_ANIMAL"
        }
    ]
}
</script>

<%-- ========================================
     6. WEBSITE SCHEMA (Homepage)
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "WebSite",
    "name": "LearnerDNA",
    "alternateName": "StreamFit",
    "url": "https://learnerdna.com",
    "potentialAction": {
        "@type": "SearchAction",
        "target": {
            "@type": "EntryPoint",
            "urlTemplate": "https://learnerdna.com/search?q={search_term_string}"
        },
        "query-input": "required name=search_term_string"
    }
}
</script>

<%-- ========================================
     7. COURSE SCHEMA (Educational Guide)
     Example: Stream Selection Guide
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Course",
    "name": "Complete Guide to Stream Selection After 10th",
    "description": "Comprehensive guide to help students choose between Science, Commerce, and Arts streams after 10th grade. Includes aptitude assessment, career paths, and decision framework.",
    "provider": {
        "@type": "Organization",
        "name": "LearnerDNA",
        "sameAs": "https://learnerdna.com"
    },
    "educationalLevel": "Secondary Education",
    "inLanguage": "en-IN",
    "isAccessibleForFree": true,
    "hasCourseInstance": {
        "@type": "CourseInstance",
        "courseMode": "online",
        "courseWorkload": "PT30M"
    }
}
</script>

<%-- ========================================
     8. HOW-TO SCHEMA (Guide Pages)
     Example: How to Choose Stream
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "HowTo",
    "name": "How to Choose the Right Stream After 10th",
    "description": "Step-by-step guide to help students make an informed decision about stream selection after 10th grade.",
    "image": "https://learnerdna.com/assets/guides/stream-selection.png",
    "totalTime": "PT20M",
    "estimatedCost": {
        "@type": "MonetaryAmount",
        "currency": "INR",
        "value": "0"
    },
    "step": [
        {
            "@type": "HowToStep",
            "position": 1,
            "name": "Take an Aptitude Test",
            "text": "Start by taking a comprehensive aptitude test to identify your cognitive strengths and natural abilities.",
            "url": "https://learnerdna.com/diagnostic"
        },
        {
            "@type": "HowToStep",
            "position": 2,
            "name": "Assess Your Interests",
            "text": "Evaluate your passion areas and subjects you genuinely enjoy studying."
        },
        {
            "@type": "HowToStep",
            "position": 3,
            "name": "Research Career Opportunities",
            "text": "Explore career paths available in each stream and their future prospects."
        },
        {
            "@type": "HowToStep",
            "position": 4,
            "name": "Consider Long-term Goals",
            "text": "Think about your aspirations and how each stream aligns with your future plans."
        },
        {
            "@type": "HowToStep",
            "position": 5,
            "name": "Consult Experts",
            "text": "Discuss your options with career counselors, teachers, and mentors."
        }
    ]
}
</script>

<%-- ========================================
     9. REVIEW SCHEMA (Testimonials)
     Example: Student Review
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Review",
    "itemReviewed": {
        "@type": "EducationalOrganization",
        "name": "LearnerDNA"
    },
    "reviewRating": {
        "@type": "Rating",
        "ratingValue": "5",
        "bestRating": "5"
    },
    "author": {
        "@type": "Person",
        "name": "Priya S."
    },
    "reviewBody": "LearnerDNA helped me choose engineering over medical with confidence. The cognitive radar test showed my strengths clearly. Highly recommend for confused students!"
}
</script>

<%-- ========================================
     10. AGGREGATE RATING SCHEMA (Homepage)
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Product",
    "name": "LearnerDNA Student Diagnostic Platform",
    "description": "Free aptitude and career guidance tests for students",
    "brand": {
        "@type": "Brand",
        "name": "LearnerDNA"
    },
    "aggregateRating": {
        "@type": "AggregateRating",
        "ratingValue": "4.7",
        "reviewCount": "10247",
        "bestRating": "5",
        "worstRating": "1"
    },
    "offers": {
        "@type": "Offer",
        "price": "0",
        "priceCurrency": "INR",
        "availability": "https://schema.org/InStock"
    }
}
</script>

<%-- ========================================
     11. VIDEO SCHEMA (If you add video content)
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "VideoObject",
    "name": "How to Take the Exam Spirit Animal Test",
    "description": "Quick tutorial on taking the Exam Spirit Animal test and understanding your results",
    "thumbnailUrl": "https://learnerdna.com/assets/videos/spirit-animal-thumb.jpg",
    "uploadDate": "2025-01-15",
    "duration": "PT3M",
    "contentUrl": "https://learnerdna.com/videos/spirit-animal-tutorial.mp4",
    "embedUrl": "https://www.youtube.com/embed/VIDEO_ID"
}
</script>

<%-- ========================================
     12. EVENT SCHEMA (Webinars/Workshops)
     ======================================== --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Event",
    "name": "Stream Selection Webinar for Class 10 Students",
    "description": "Free webinar on how to choose the right stream after 10th grade",
    "startDate": "2025-03-15T18:00:00+05:30",
    "endDate": "2025-03-15T19:30:00+05:30",
    "eventStatus": "https://schema.org/EventScheduled",
    "eventAttendanceMode": "https://schema.org/OnlineEventAttendanceMode",
    "location": {
        "@type": "VirtualLocation",
        "url": "https://learnerdna.com/webinar/stream-selection"
    },
    "organizer": {
        "@type": "Organization",
        "name": "LearnerDNA",
        "url": "https://learnerdna.com"
    },
    "offers": {
        "@type": "Offer",
        "price": "0",
        "priceCurrency": "INR",
        "availability": "https://schema.org/InStock",
        "url": "https://learnerdna.com/webinar/register"
    }
}
</script>

<%-- ========================================
     IMPLEMENTATION NOTES:
     
     1. Choose the appropriate schema for each page type
     2. Customize values to match actual content
     3. Validate using Google Rich Results Test
     4. Test in Google Search Console
     5. Monitor performance in search results
     
     Priority Implementation:
     - Organization Schema: Homepage
     - Quiz Schema: All test pages
     - FAQ Schema: FAQ page
     - Breadcrumb Schema: All pages
     - Article Schema: Archetype and guide pages
     ======================================== --%>

