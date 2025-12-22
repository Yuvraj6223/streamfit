<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="pageTitle" value="Free Diagnostic Tests for Students | Learning Style & Career Assessment | LearnerDNA" />
    <g:set var="pageDescription" value="Take 9 free diagnostic tests to discover your learning style, cognitive strengths, and ideal career path. Scientifically validated assessments for students aged 14-20. No signup required." />
    <g:set var="pageKeywords" value="diagnostic tests, learning style assessment, career aptitude test, cognitive assessment, student tests" />

    <!-- Structured Data for Diagnostic Tests Hub -->
    <g:set var="structuredData">
    {
        "@context": "https://schema.org",
        "@type": "ItemList",
        "name": "LearnerDNA Diagnostic Tests",
        "description": "Comprehensive suite of 9 diagnostic tests for students",
        "numberOfItems": 9,
        "itemListElement": [
            {
                "@type": "ListItem",
                "position": 1,
                "item": {
                    "@type": "Quiz",
                    "name": "Exam Spirit Animal",
                    "description": "Discover your exam-taking personality",
                    "educationalLevel": "High School",
                    "timeRequired": "PT5M"
                }
            },
            {
                "@type": "ListItem",
                "position": 2,
                "item": {
                    "@type": "Quiz",
                    "name": "Cognitive Radar",
                    "description": "Identify your cognitive strengths",
                    "educationalLevel": "High School",
                    "timeRequired": "PT7M"
                }
            }
        ]
    }
    </g:set>

    <title>${pageTitle}</title>
    <style>
        .diagnostic-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 20px;
            text-align: center;
        }
        
        .diagnostic-hero h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .diagnostic-hero p {
            font-size: 1.3rem;
            opacity: 0.95;
            max-width: 700px;
            margin: 0 auto;
        }
        
        .tests-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 60px 20px;
        }
        
        .test-category {
            margin-bottom: 60px;
        }
        
        .test-category h2 {
            font-size: 2rem;
            margin-bottom: 10px;
            color: #333;
        }
        
        .test-category-desc {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 30px;
        }
        
        .test-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }
        
        .test-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            cursor: pointer;
            border: 2px solid transparent;
        }
        
        .test-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            border-color: #667eea;
        }
        
        .test-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        .test-name {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: #333;
        }
        
        .test-description {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .test-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            font-size: 0.9rem;
            color: #888;
        }
        
        .test-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s ease;
        }
        
        .test-btn:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .progress-section {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 40px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .progress-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .progress-bar {
            background: #e0e0e0;
            height: 12px;
            border-radius: 6px;
            overflow: hidden;
        }
        
        .progress-fill {
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            height: 100%;
            transition: width 0.5s ease;
        }
    </style>
</head>
<body>
    <div class="diagnostic-hero">
        <h1>🧬 Discover Your Learning DNA</h1>
        <p>Take our comprehensive diagnostic tests to unlock personalized insights about your learning style, cognitive strengths, and career direction.</p>
    </div>
    
    <div class="tests-container">
        <!-- Progress Section -->
        <div class="progress-section">
            <div class="progress-header">
                <h3>Your Progress</h3>
                <span id="progress-text">0 of 9 tests completed</span>
            </div>
            <div class="progress-bar">
                <div class="progress-fill" id="progress-fill" style="width: 0%"></div>
            </div>
        </div>
        
        <!-- Exam Tests -->
        <div class="test-category">
            <h2>📚 Exam-Focused Tests</h2>
            <p class="test-category-desc">Understand your exam-taking personality, cognitive strengths, focus patterns, and risk-taking behavior.</p>
            <div class="test-grid" id="exam-tests-grid">
                <!-- Tests will be loaded here -->
            </div>
        </div>
        
        <!-- Career Tests -->
        <div class="test-category">
            <h2>🚀 Career Direction Tests</h2>
            <p class="test-category-desc">Discover your curiosity orientation, learning modality, motivation drivers, and work preferences.</p>
            <div class="test-grid" id="career-tests-grid">
                <!-- Tests will be loaded here -->
            </div>
        </div>
    </div>
    
    <script>
        // Test icons mapping
        const testIcons = {
            'SPIRIT_ANIMAL': '🦉',
            'COGNITIVE_RADAR': '🧠',
            'FOCUS_STAMINA': '⚡',
            'GUESSWORK_QUOTIENT': '🎲',
            'CURIOSITY_COMPASS': '🧭',
            'MODALITY_MAP': '🎨',
            'CHALLENGE_DRIVER': '🏆',
            'WORK_MODE': '💼',
            'PATTERN_SNAPSHOT': '🔍'
        };
        
        // Load tests
        async function loadTests() {
            try {
                const response = await fetch('/api/diagnostic/tests');
                const tests = await response.json();
                
                const examTests = tests.filter(t => t.testType === 'EXAM');
                const careerTests = tests.filter(t => t.testType === 'CAREER');
                
                renderTests(examTests, 'exam-tests-grid');
                renderTests(careerTests, 'career-tests-grid');
                
                // Update progress
                updateProgress(tests);
            } catch (error) {
                console.error('Error loading tests:', error);
            }
        }
        
        function renderTests(tests, containerId) {
            const container = document.getElementById(containerId);
            container.innerHTML = tests.map(test => `
                <div class="test-card" onclick="startTest('${test.testId}')">
                    <div class="test-icon">${testIcons[test.testId] || '📝'}</div>
                    <div class="test-name">${test.testName}</div>
                    <div class="test-description">${test.description}</div>
                    <div class="test-meta">
                        <span>📊 ${test.questionCount} questions</span>
                        <span>⏱️ ${test.estimatedMinutes} min</span>
                    </div>
                    <button class="test-btn">Start Test</button>
                </div>
            `).join('');
        }
        
        function updateProgress(tests) {
            // This would be updated based on actual user progress
            // For now, showing 0%
            const completed = 0;
            const total = tests.length;
            const percentage = (completed / total) * 100;
            
            document.getElementById('progress-text').textContent = `${completed} of ${total} tests completed`;
            document.getElementById('progress-fill').style.width = `${percentage}%`;
        }
        
        function startTest(testId) {
            window.location.href = `/diagnostic/test/${testId}`;
        }
        
        // Load tests on page load
        document.addEventListener('DOMContentLoaded', loadTests);
    </script>
</body>
</html>

