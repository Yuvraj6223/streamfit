<!DOCTYPE html>
<html lang="en-IN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title><g:message code="page.title" default="My learning DNA | learnerDNA"/></title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
            rel="stylesheet">
    <asset:stylesheet src="dashboard.css"/>
</head>

<body>

<nav class="main-nav">
    <div class="nav-container">
        <g:link uri="/" class="nav-logo">
            <asset:image src="logo1.png" alt="learnerDNA - Free Student Aptitude Test" onerror="this.src='https://placehold.co/150x40?text=learnerDNA'" />
        </g:link>
    </div>
</nav>

<div class="glass-console">

    <%-- PRE-CALCULATIONS: Centralize logic to keep HTML clean --%>
    <g:set var="totalTests" value="${model.stats.totalTests ?: 9}" />
    <g:set var="completedTests" value="${model.stats.totalTestsCompleted}" />
    <g:set var="completionPct" value="${totalTests > 0 ? (completedTests / totalTests) * 100 : 0}" />
    
    <%-- MAPPING: Map result types to assets to avoid if/else chains --%>
    <g:set var="animalImages" value="${['WISE_OWL': 'owl.png', 'DISCIPLINED_BEE': 'bee.png', 'STRATEGIC_WOLF': 'wolf.png', 'BOLD_TIGER': 'tiger.png']}" />

    <%-- DYNAMIC STREAMS: Calculate based on cognitive scores --%>
    <%
        def calculatedStreams = model.suggestedStreams
        if (!calculatedStreams && model.cognitiveRadar?.scoreBreakdown) {
            def s = model.cognitiveRadar.scoreBreakdown
            // Normalize scores based on chart logic (Logic/Verbal out of 2, others out of 1)
            def logic = (s.logic ?: 0) / 2.0 * 100
            def verbal = (s.verbal ?: 0) / 2.0 * 100
            def spatial = (s.spatial ?: 0) * 100
            def speed = (s.speed ?: 0) * 100

            def lib = [
                [id: 'engineering', title: 'Engineering', icon: '🏗️', w: [logic: 0.5, spatial: 0.5], outcome: 'Build Systems'],
                [id: 'law', title: 'Law', icon: '⚖️', w: [verbal: 0.8, logic: 0.2], outcome: 'Defend Rights'],
                [id: 'cs', title: 'Comp. Science', icon: '💻', w: [logic: 0.6, speed: 0.4], outcome: 'Innovate Tech'],
                [id: 'design', title: 'Design', icon: '🎨', w: [spatial: 0.8, verbal: 0.2], outcome: 'Create Art'],
                [id: 'medicine', title: 'Medicine', icon: '🩺', w: [logic: 0.4, speed: 0.3, verbal: 0.3], outcome: 'Heal Others'],
                [id: 'business', title: 'Business', icon: '💼', w: [verbal: 0.5, logic: 0.3, speed: 0.2], outcome: 'Lead Teams']
            ]

            calculatedStreams = lib.collect { item ->
                def score = 0
                if (item.w.logic) score += logic * item.w.logic
                if (item.w.verbal) score += verbal * item.w.verbal
                if (item.w.spatial) score += spatial * item.w.spatial
                if (item.w.speed) score += speed * item.w.speed
                
                def desc = score > 85 ? "Your profile is a strong match." : (score > 70 ? "Good potential with effort." : "A challenging path.")
                [id: item.id, title: item.title, icon: item.icon, match: score.toInteger(), isBest: false, desc: desc, outcome: item.outcome]
            }.sort { -it.match }.take(3)
            if (calculatedStreams) calculatedStreams[0].isBest = true
        }
        // Expose to view
        pageScope.suggestedStreams = calculatedStreams ?: [[id: 'engineering', title: 'Engineering', icon: '🏗️', match: 0, isBest: false, desc: 'Complete tests to reveal match.', outcome: 'Secure Future'], [id: 'cs', title: 'Comp. Science', icon: '💻', match: 0, isBest: false, desc: 'Complete tests to reveal match.', outcome: 'Reach Goals'], [id: 'law', title: 'Law', icon: '⚖️', match: 0, isBest: false, desc: 'Complete tests to reveal match.', outcome: 'Defend Rights']]
    %>

    <header class="console-header anim-pop">
        <div class="welcome-text">Hello, ${model.user.name ?: 'User'} 👋</div>
        <div class="sub-text">
            <g:if test="${completionPct > 0}">
                <span>🗺️ ${completionPct as int}% mapped!</span>
            </g:if>
            <g:else>
                <span>🔮 0% mapped. Let the journey begin!</span>
            </g:else>
        </div>
    </header>

    <div class="dashboard-grid">

        <div class="glass-panel identity-core anim-pop d-2 area-identity">
                <g:if test="${completedTests >= totalTests && model.spiritAnimal}">
                    <div class="panel-label" style="justify-content: center; color: var(--pop-purple); font-size: 0.8rem;">
                        <span>✨ YOUR IDENTITY REVEALED ✨</span>
                    </div>
                    <g:set var="animalImage" value="${animalImages[model.spiritAnimal.resultType] ?: 'brain.png'}" />
                    <div class="avatar-wrapper-float">
                        <div class="core-ring cr-1"></div>
                        <div class="core-ring cr-2"></div>
                        <div class="core-ring cr-3"></div>
                        <div class="animal-avatar-container" style="background: linear-gradient(180deg, #E0DEFF 0%, #FFD6C9 100%);">
                            <asset:image src="${animalImage}" alt="${model.spiritAnimal.resultTitle}" class="avatar-img" />
                        </div>
                    </div>
                    <div class="animal-title">You are the ${model.spiritAnimal.resultTitle}!</div>
                    <div class="animal-archetype">"${model.spiritAnimal.resultType.replaceAll('_', ' ')}"</div>
                    <div class="archetype-desc" style="font-style: italic; max-width: 85%; margin: 16px auto 24px auto;">“${model.spiritAnimal.resultSummary}”</div>
                </g:if>
                <g:else>
                    <div class="panel-label" style="justify-content: center; color: var(--text-grey); font-size: 0.8rem;">
                        <span>🔮 YOUR IDENTITY AWAITS 🔮</span>
                    </div>
                    <div class="avatar-wrapper-float">
                        <div class="core-ring cr-1"></div>
                        <div class="core-ring cr-2"></div>
                        <div class="core-ring cr-3"></div>
                        <div class="animal-avatar-container">
                            <span style="font-size: 4rem;">🔒</span>
                        </div>
                    </div>
                    <div class="animal-title" style="font-size: 1.4rem; color: #3B2F5F;">Discover Your Inner Spark</div>
                    <div class="archetype-desc" style="max-width: 90%; margin-top: 8px; margin-bottom: 24px;">Complete your tests to reveal the core of your learning identity and unlock your hidden strengths.</div>
                </g:else>
            <div class="step-progress-container">
                <div class="step-progress-label">Your Discovery Journey</div>
                <div class="step-progress-dots">
                    <g:each in="${1..totalTests}" var="i">
                        <div class="step-dot ${i <= completedTests ? 'completed' : ''}" title="Discovery ${i}"></div>
                    </g:each>
                </div>
                <div class="step-progress-subtext">
                    <g:if test="${completionPct < 100}">
                        ${completedTests} of ${totalTests} discoveries made
                    </g:if>
                    <g:else>
                        Journey Complete!
                    </g:else>
                </div>

                <div class="step-progress-cta">
                    <g:if test="${completionPct < 100}">
                        Next Discovery: <g:link controller="personality" action="start" style="color:var(--charcoal-teal); font-weight:700; text-decoration:none;">Begin</g:link>
                    </g:if>
                    <g:else>
                        ✨ You've revealed your full learning DNA!
                    </g:else>
                </div>
            </div>
        </div>

        <div class="glass-panel anim-pop d-4 area-latest-result">
            <div class="panel-label">
                <span>Test History</span>
            </div>
            <g:if test="${model.completedTestResults}">
                <div class="latest-result-content">
                    <g:each in="${model.completedTestResults.sort { a, b -> (b.session.completedAt?.time ?: 0) <=> (a.session.completedAt?.time ?: 0) }.take(5)}" var="test">
                        <g:link controller="result" action="resultPage" params="[sessionId: test.session.sessionId]" class="history-card">
                            <div class="history-card-icon">${test.result.emoji}</div>
                            <div class="history-card-info">
                                <div class="history-card-title">${test.result.testName}</div>
                                <g:if test="${test.result.resultTitle}">
                                    <div class="history-card-one-liner">"${test.result.resultTitle}"</div>
                                </g:if>
                                <div class="history-card-date">Completed on <g:formatDate date="${test.session.completedAt}" format="dd MMM yyyy"/></div>
                            </div>
                            <div class="history-card-action">View Result &rarr;</div>
                        </g:link>
                    </g:each>
                </div>
            </g:if>
            <g:else>
                <div class="latest-result-content">
                    <p>No tests completed yet. Complete a test to see your history.</p>
                </div>
            </g:else>

            <div class="pending-tests-container">
                <h4>Available Tests</h4>
                <g:if test="${model.pendingTests}">
                    <div class="pending-tests-list">
                        <g:each in="${model.pendingTests.sort { it.testName }}" var="test">
                            <div class="pending-test-item">
                                <div class="pending-test-name">${test.testName}</div>
                                <g:link controller="personality" action="start" params="[testId: test.testId]">
                                    Take Test
                                </g:link>
                            </div>
                        </g:each>
                    </div>
                </g:if>
                <g:else>
                    <p>
                        You've completed all available tests!
                    </p>
                </g:else>
            </div>
        </div>

        <div class="glass-panel anim-pop d-1 area-traits ${completedTests < totalTests ? 'locked' : ''}">
            <g:if test="${completedTests < totalTests}">
                <div class="lock-overlay">
                    <div class="lock-box">
                        <h4>Unlock Key Traits</h4>
                        <p>Complete all ${totalTests} tests to reveal your key traits.</p>
                        <g:link controller="personality" action="start" style="display: inline-block; padding: 10px 16px; background: var(--pop-purple); color: white; font-weight: 700; font-size: 0.85rem; border-radius: 20px; text-decoration: none;">Take a Test</g:link>
                    </div>
                </div>
            </g:if>
            <div class="panel-label">
                <span>Key Traits</span>
            </div>
            <div class="traits-grid">
                <g:if test="${model.spiritAnimal}">
                    <div class="trait-token">
                        <div class="tt-label">🧠 Curiosity</div>
                        <div class="tt-val">${model.spiritAnimal.scoreBreakdown.primaryTrait.capitalize()}</div>
                        <div class="tt-desc">Your dominant approach to new information.</div>
                    </div>
                </g:if>
                <g:if test="${model.cognitiveRadar}">
                    <div class="trait-token">
                        <div class="tt-label">👁️ Learning Mode</div>
                        <div class="tt-val">${model.cognitiveRadar.scoreBreakdown.primaryPillar.capitalize()}</div>
                        <div class="tt-desc">Your strongest cognitive channel for learning.</div>
                    </div>
                </g:if>
                <g:if test="${model.spiritAnimal}">
                    <div class="trait-token">
                        <div class="tt-label">⚡ Driver</div>
                        <div class="tt-val">${model.spiritAnimal.scoreBreakdown.secondaryTrait.capitalize()}</div>
                        <div class="tt-desc">What you prioritize when solving problems.</div>
                    </div>
                </g:if>
                <g:if test="${model.workMode}">
                    <div class="trait-token">
                        <div class="tt-label">👤 Work Style</div>
                        <div class="tt-val">${model.workMode.resultTitle}</div>
                        <div class="tt-desc">The environment where you are most effective.</div>
                    </div>
                </g:if>
            </div>
        </div>

        <div class="glass-panel anim-pop d-3 area-radar ${completedTests < totalTests ? 'locked' : ''}">
            <g:if test="${completedTests < totalTests}">
                <div class="lock-overlay">
                    <div class="lock-box">
                        <h4>Unlock Your Cognitive Map</h4>
                        <p>Complete all ${totalTests} tests to reveal your Cognitive Map.</p>
                        <g:link controller="personality" action="start" style="display: inline-block; padding: 10px 16px; background: var(--pop-purple); color: white; font-weight: 700; font-size: 0.85rem; border-radius: 20px; text-decoration: none;">Take a Test</g:link>
                    </div>
                </div>
            </g:if>
            <div class="panel-label">Cognitive Radar</div>

            <div class="radar-content-wrapper" <g:if test="${completedTests < totalTests}">style="filter: blur(10px); opacity: 0;"</g:if>>
                <div class="radar-bars">
                    <g:if test="${model.cognitiveRadar}">
                        <g:set var="logicPct" value="${(model.cognitiveRadar.scoreBreakdown.logic / 2) * 100}" />
                        <g:set var="verbalPct" value="${(model.cognitiveRadar.scoreBreakdown.verbal / 2) * 100}" />
                        <g:set var="spatialPct" value="${(model.cognitiveRadar.scoreBreakdown.spatial / 1) * 100}" />
                        <g:set var="speedPct" value="${(model.cognitiveRadar.scoreBreakdown.speed / 1) * 100}" />
                        
                        <div class="skill-row">
                            <div class="skill-icon">🧩</div>
                            <div class="skill-data">
                                <div class="sd-head"><span>Logic</span> <span>${logicPct.toInteger()}%</span></div>
                                <div class="sd-track">
                                    <div class="sd-fill" style="width: ${logicPct}%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="skill-row">
                            <div class="skill-icon">🗣️</div>
                            <div class="skill-data">
                                <div class="sd-head"><span>Verbal</span> <span>${verbalPct.toInteger()}%</span></div>
                                <div class="sd-track">
                                    <div class="sd-fill" style="width: ${verbalPct}%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="skill-row">
                            <div class="skill-icon">📐</div>
                            <div class="skill-data">
                                <div class="sd-head"><span>Spatial</span> <span>${spatialPct.toInteger()}%</span></div>
                                <div class="sd-track">
                                    <div class="sd-fill" style="width: ${spatialPct}%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="skill-row">
                            <div class="skill-icon">⚡</div>
                            <div class="skill-data">
                                <div class="sd-head"><span>Speed</span> <span>${speedPct.toInteger()}%</span></div>
                                <div class="sd-track">
                                    <div class="sd-fill" style="width: ${speedPct}%"></div>
                                </div>
                            </div>
                        </div>
                    </g:if>
                    <g:else>
                        <p style="text-align: center; width: 100%;">Complete the 'Brain Power Game' to reveal your cognitive scores.</p>
                    </g:else>
                </div>
            </div>
        </div>

        <div class="results-deck anim-pop d-3 ${completedTests < totalTests ? 'locked' : ''}">
            <g:if test="${completedTests < totalTests}">
                <div class="lock-overlay">
                    <div class="lock-box">
                        <h4>Unlock learnerDNA Suggestions</h4>
                        <p>Complete all ${totalTests} tests to see your recommended career streams.</p>
                        <g:link controller="personality" action="start" style="display: inline-block; padding: 10px 16px; background: var(--pop-purple); color: white; font-weight: 700; font-size: 0.85rem; border-radius: 20px; text-decoration: none;">Take a Test</g:link>
                    </div>
                </div>
            </g:if>

            <div class="panel-label">learnerDNA Suggestions (Top 3)</div>

            <div class="cards-scroller" id="stream-cards">
                <g:each in="${suggestedStreams}" var="stream">
                    <div class="stream-card ${stream.isBest ? 'hero-card' : ''}">
                        <div class="sc-match-tag ${stream.isBest ? 'best' : ''}">
                            ${stream.match}% Match ${stream.isBest ? '• Best Fit' : ''}
                        </div>
                        <div>
                            <div class="sc-icon">${stream.icon}</div>
                            <div class="sc-title">${stream.title}</div>
                            <div class="sc-desc">${stream.desc}</div>
                        </div>
                        <div class="sc-action">
                            <span style="font-size:0.7rem; color:${stream.isBest ? 'var(--text-dark); font-weight: 600;' : 'var(--text-grey);'}">Outcome: ${stream.outcome}</span>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>

        <div class="glass-panel area-next anim-pop d-3">
            <div class="panel-label">Your Next Steps</div>
            <div class="next-steps-list">

                <g:link controller="result" action="testPage" params="[testId: 'GUESSWORK_QUOTIENT']" class="ns-item primary">
                    <span class="ns-tag">Start Here</span>
                    <h4>Calibrate Decisions</h4>
                    <p>Take the 2-minute Guesswork Quotient test to complete your profile.</p>
                </g:link>

                <g:link controller="career" action="details" id="engineering" class="ns-item secondary">
                    <h4>Explore Engineering</h4>
                    <p>See how your logic score maps to this career path.</p>
                </g:link>

                <g:link controller="training" action="spatialDrill"  class="ns-item secondary">
                <h4>Train Spatial Skills</h4>
                    <p>Start a quick 5-minute drill to boost your stats.</p>
                </g:link>

            </>
        </div>

    </div>

    <div style="text-align: center; margin-top: 40px; margin-bottom: 10px; color: var(--text-dark); opacity: 0.8; font-weight: 600; font-size: 1.1rem; font-family: var(--font-display);"
         class="anim-pop d-3">
        Your potential is mapped. Trust your unique strengths.
    </div>

</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Animate progress bars on load
        <g:if test="${completionPct >= 100}">
            document.querySelectorAll('.locked').forEach(el => {
                el.classList.remove('locked');
                const overlay = el.querySelector('.lock-overlay');
                if (overlay) overlay.remove();
            });
        </g:if>

        setTimeout(() => {
            document.querySelectorAll('.sd-fill').forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0%';
                setTimeout(() => bar.style.width = width, 100);
            });

            const mainProg = document.querySelector('.prog-fill');
            if (mainProg) {
                const mainW = mainProg.style.width;
                mainProg.style.width = '0%';
                setTimeout(() => mainProg.style.width = mainW, 300);
            }
        }, 500);

    });
</script>
</body>

</html>