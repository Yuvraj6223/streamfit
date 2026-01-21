<head>
    <meta name="layout" content="main"/>
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
    <div class="glass-console">

    <%-- PRE-CALCULATIONS: Centralize logic to keep HTML clean --%>
    <g:set var="totalGames" value="${model?.stats?.totalTests ?: 9}" />
    <g:set var="completedGames" value="${model?.stats?.totalTestsCompleted ?: 0}" />
    <g:set var="completionPct" value="${totalGames > 0 ? (completedGames / totalGames) * 100 : 0}" />
    
    <%-- MAPPING: Map result types to assets to avoid if/else chains --%>
    <g:set var="animalImages" value="${['WISE_OWL': 'owl.png', 'DISCIPLINED_BEE': 'bee.png', 'STRATEGIC_WOLF': 'wolf.png', 'BOLD_TIGER': 'tiger.png']}" />
    <g:set var="resultTitlesMap" value="${[
            'BOLD_TIGER': 'THE BOLD TIGER',
            'WISE_OWL': 'THE WISE OWL',
            'DISCIPLINED_BEE': 'THE DISCIPLINED BEE',
            'STRATEGIC_WOLF': 'THE STRATEGIC WOLF',
            'ANALYTICAL_DIAMOND': 'THE ANALYTICAL DIAMOND',
            'VERBAL_VIRTUOSO': 'THE VERBAL VIRTUOSO',
            'PRECISE_PROCESSOR': 'THE PRECISE PROCESSOR',
            'VISUAL_VISIONARY': 'THE VISUAL VISIONARY',
            'COGNITIVE_LOGIC': 'THE ANALYTICAL DIAMOND',
            'COGNITIVE_VERBAL': 'THE VERBAL VIRTUOSO',
            'COGNITIVE_SPATIAL': 'THE VISUAL VISIONARY',
            'COGNITIVE_SPEED': 'THE PRECISE PROCESSOR',
            'THEORIST': 'THE THEORIST',
            'BUILDER': 'THE BUILDER',
            'EMPATH': 'THE EMPATH',
            'CHALLENGER': 'THE CHALLENGER',
            'MARATHONER': 'THE MARATHONER',
            'SPRINTER': 'THE SPRINTER',
            'SAFE_PLAYER': 'THE SAFE PLAYER',
            'QUITTER': 'THE QUICK STARTER',
            'BALANCED_STRATEGIST': 'THE BALANCED STRATEGIST',
            'HIGH_ROLLER': 'THE HIGH ROLLER',
            'UNDER_ESTIMATOR': 'THE HUMBLE ACHIEVER',
            'HESITANT_SEARCHER': 'THE CAREFUL SEARCHER',
            'VISUAL': 'THE VISUAL LEARNER',
            'AUDITORY': 'THE AUDITORY LEARNER',
            'KINESTHETIC': 'THE KINESTHETIC LEARNER',
            'CONCEPTUAL': 'THE CONCEPTUAL LEARNER',
            'VERBAL': 'THE VERBAL PATTERN MASTER',
            'NUMERIC': 'THE NUMERIC PATTERN MASTER',
            'STRUCTURED_SOLOIST': 'THE STRUCTURED SOLOIST',
            'STRUCTURED_COLLABORATOR': 'THE STRUCTURED COLLABORATOR',
            'FREEFORM_EXPLORER': 'THE FREEFORM EXPLORER',
            'CHAOTIC_CREATIVE': 'THE CHAOTIC CREATIVE',
            'EXTROVERT': 'THE SOCIAL BUTTERFLY',
            'INTROVERT': 'THE DEEP THINKER',
            'LOGIC_BUILDER': 'THE LOGIC BUILDER',
            'CURIOUS_THINKER': 'THE CURIOUS THINKER',
            'FOCUS_FINISHER': 'THE FOCUS FINISHER',
            'DECISION_MAKER': 'FAST DECISION MAKER',
            'ADAPTIVE_LEARNER': 'THE ADAPTIVE LEARNER',
            'DETAIL_DETECTIVE': 'THE DETAIL DETECTIVE',
            'STRATEGIC_PLANNER': 'THE STRATEGIC PLANNER',
            'CREATIVE_CONNECTOR': 'CREATIVE CONNECTOR'
    ]}"/>

    <%-- DYNAMIC STREAMS: This is now calculated in the controller --%>
    <g:set var="suggestedStreams" value="${model?.suggestedStreams ?: []}" />

    <header class="console-header anim-pop">
        <div class="welcome-text">Hello, ${model?.user?.name ?: 'User'} 👋</div>
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
                <g:if test="${completedGames >= totalGames && model?.spiritAnimal}">
                    <div class="panel-label" style="justify-content: center; color: var(--pop-purple); font-size: 0.8rem;">
                        <span>✨ YOUR IDENTITY REVEALED ✨</span>
                    </div>
                    <g:set var="animalImage" value="${animalImages[model?.spiritAnimal?.resultType] ?: 'brain.png'}" />
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
                    <div class="archetype-desc" style="max-width: 90%; margin-top: 8px; margin-bottom: 24px;">Complete your games to reveal the core of your learning identity and unlock your hidden strengths.</div>
                </g:else>
            <div class="step-progress-container">
                <div class="step-progress-label">Your Discovery Journey</div>
                <div class="step-progress-dots">
                    <g:each in="${1..totalGames}" var="i">
                        <div class="step-dot ${i <= completedGames ? 'completed' : ''}" title="Discovery ${i}"></div>
                    </g:each>
                </div>
                <div class="step-progress-subtext">
                    <g:if test="${completionPct < 100}">
                        ${completedGames} of ${totalGames} discoveries made
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
                <span>Game History</span>
            </div>
            <g:if test="${model?.completedTestResults}">
                <div class="latest-result-content">
                    <g:each in="${model?.completedTestResults?.sort { a, b -> (b.session?.completedAt?.time ?: 0) <=> (a.session?.completedAt?.time ?: 0) }?.take(9)}" var="test">
                        <g:link controller="result" action="resultPage" params="[sessionId: test.session?.sessionId]" class="history-card">
                            <div class="history-card-icon">${test.result?.emoji}</div>
                            <div class="history-card-info">
                                <div class="history-card-title">${test.result?.testName}</div>

                                <g:set var="rawTitle" value="${test.result?.resultTitle}" />
                                <g:set var="lookupKey" value="${rawTitle?.toString()?.trim()?.toUpperCase()?.replaceAll(' ', '_')}" />
                                
                                <g:if test="${rawTitle}">
                                    <div class="history-card-one-liner">
                                        ${(resultTitlesMap && resultTitlesMap[lookupKey]) ? resultTitlesMap[lookupKey] : rawTitle}
                                    </div>
                                </g:if>
                                <div class="history-card-date">Completed on <g:formatDate date="${test.session?.completedAt}" format="dd MMM yyyy"/></div>
                            </div>
                            <div class="history-card-action">View Result &rarr;</div>
                        </g:link>
                    </g:each>
                </div>
            </g:if>
            <g:else>
                <div class="latest-result-content">
                    <p>No games completed yet. Complete a game to see your history.</p>
                </div>
            </g:else>

            <div class="pending-tests-container">
                <h4>Available Games</h4>
                <g:if test="${model?.pendingTests}">
                    <div class="pending-tests-list">
                        <g:each in="${model?.pendingTests?.sort { it.testName }}" var="test">
                            <div class="pending-test-item">
                                <div class="pending-test-name">${test.testName}</div>
                                <g:link controller="personality" action="start" params="[testId: test.testId]">
                                    Start Game
                                </g:link>
                            </div>
                        </g:each>
                    </div>
                </g:if>
                <g:else>
                    <p>
                        You've completed all available games!
                    </p>
                </g:else>
            </div>
        </div>

        <div class="glass-panel anim-pop d-1 area-traits ${completedGames < totalGames ? 'locked' : ''}">
            <g:if test="${completedGames < totalGames}">
                <div class="lock-overlay">
                    <div class="lock-box">
                        <h4>Unlock Key Traits</h4>
                        <p>Complete all ${totalGames} games to reveal your key traits.</p>
                        <g:link controller="personality" action="start" style="display: inline-block; padding: 10px 16px; background: var(--pop-purple); color: white; font-weight: 700; font-size: 0.85rem; border-radius: 20px; text-decoration: none;">Start a Game</g:link>
                    </div>
                </div>
            </g:if>
            <div class="panel-label">
                <span>Key Traits</span>
            </div>
            <div class="traits-grid">
                <g:if test="${model?.spiritAnimal}">
                    <div class="trait-token">
                        <div class="tt-label">🧠 Curiosity</div>
                        <div class="tt-val">${model?.spiritAnimal?.scoreBreakdown?.primaryTrait?.capitalize()}</div>
                        <div class="tt-desc">Your dominant approach to new information.</div>
                    </div>
                </g:if>
                <g:if test="${model?.cognitiveRadar}">
                    <div class="trait-token">
                        <div class="tt-label">👁️ Learning Mode</div>
                        <div class="tt-val">${model?.cognitiveRadar?.primaryPillar?.capitalize()}</div>
                        <div class="tt-desc">Your strongest cognitive channel for learning.</div>
                    </div>
                </g:if>
                <g:if test="${model?.spiritAnimal}">
                    <div class="trait-token">
                        <div class="tt-label">⚡ Driver</div>
                        <div class="tt-val">${model?.spiritAnimal?.scoreBreakdown?.secondaryTrait?.capitalize()}</div>
                        <div class="tt-desc">What you prioritize when solving problems.</div>
                    </div>
                </g:if>
                <g:if test="${model?.workMode}">
                    <div class="trait-token">
                        <div class="tt-label">👤 Work Style</div>
                        <div class="tt-val">${model?.workMode?.resultTitle}</div>
                        <div class="tt-desc">The environment where you are most effective.</div>
                    </div>
                </g:if>
            </div>
        </div>

        <div class="glass-panel anim-pop d-3 area-radar ${completedGames < totalGames ? 'locked' : ''}">
            <g:if test="${completedGames < totalGames}">
                <div class="lock-overlay">
                    <div class="lock-box">
                        <h4>Unlock Your Cognitive Map</h4>
                        <p>Complete all ${totalGames} games to reveal your Cognitive Map.</p>
                        <g:link controller="personality" action="start" style="display: inline-block; padding: 10px 16px; background: var(--pop-purple); color: white; font-weight: 700; font-size: 0.85rem; border-radius: 20px; text-decoration: none;">Start a Game</g:link>
                    </div>
                </div>
            </g:if>
            <div class="panel-label">Cognitive Radar</div>

            <div class="radar-content-wrapper" <g:if test="${completedGames < totalGames}">style="filter: blur(10px); opacity: 0;"</g:if>>
                <div class="radar-bars">
                    <g:if test="${model?.cognitiveRadar}">
                        <g:set var="logicPct" value="${((model?.cognitiveRadar?.scoreBreakdown?.logic ?: 0) / 2) * 100}" />
                        <g:set var="verbalPct" value="${((model?.cognitiveRadar?.scoreBreakdown?.verbal ?: 0) / 2) * 100}" />
                        <g:set var="spatialPct" value="${((model?.cognitiveRadar?.scoreBreakdown?.spatial ?: 0) / 1) * 100}" />
                        <g:set var="speedPct" value="${((model?.cognitiveRadar?.scoreBreakdown?.speed ?: 0) / 1) * 100}" />
                        
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

        <div class="results-deck anim-pop d-3 ${completedGames < totalGames ? 'locked' : ''}">
            <g:if test="${completedGames < totalGames}">
                <div class="lock-overlay">
                    <div class="lock-box">
                        <h4>Unlock learnerDNA Suggestions</h4>
                        <p>Complete all ${totalGames} games to see your recommended career streams.</p>
                        <g:link controller="personality" action="start" style="display: inline-block; padding: 10px 16px; background: var(--pop-purple); color: white; font-weight: 700; font-size: 0.85rem; border-radius: 20px; text-decoration: none;">Start a Game</g:link>
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
                    <p>Play the 2-minute Guesswork Quotient game to complete your profile.</p>
                </g:link>

                <g:link controller="career" action="details" id="engineering" class="ns-item secondary">
                    <h4>Explore Engineering</h4>
                    <p>See how your logic score maps to this career path.</p>
                </g:link>

                <g:link controller="training" action="spatialDrill"  class="ns-item secondary">
                <h4>Train Spatial Skills</h4>
                    <p>Start a quick 5-minute drill to boost your stats.</p>
                </g:link>

            </div>
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
