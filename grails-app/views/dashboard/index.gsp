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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <asset:stylesheet src="dashboard.css"/>
    <asset:stylesheet src="sharing.css"/>
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
                    <div class="animal-title">You are ${resultTitlesMap[model.spiritAnimal.resultType] ?: model.spiritAnimal.resultTitle}!</div>
                    <div class="animal-archetype">"${model.spiritAnimal.resultType.replaceAll('_', ' ')}"</div>
                    <div class="archetype-desc" style="font-style: italic; max-width: 85%; margin: 16px auto 24px auto;">“${model.spiritAnimal.summary ?: model.spiritAnimal.resultSummary}”</div>
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
                <span>Game Badges</span>
            </div>
            <g:if test="${model?.completedTestResults}">
                <div class="badge-grid">
                    <g:each in="${model?.completedTestResults}" var="test">

                        <g:set var="rawTitle" value="${test.result?.resultTitle}"/>
                        <g:set var="lookupKey"
                               value="${rawTitle?.toString()?.trim()?.toUpperCase()?.replaceAll(' ', '_')}"/>

                        <g:link controller="result" action="resultPage"
                                params="[sessionId: test.session?.sessionId]" class="badge">
                            <div class="badge-icon">${test.result?.emoji}</div>
                            <div class="badge-title">
                                ${(resultTitlesMap && resultTitlesMap[lookupKey]) ? resultTitlesMap[lookupKey] : rawTitle}
                            </div>
                            <div class="badge-subtitle">${test.result?.testName}</div>
                            <div class="badge-date"><g:formatDate date="${test.session?.completedAt}"
                                                                 format="dd MMM yyyy"/></div>
                        </g:link>
                    </g:each>
                </div>
            </g:if>
            <g:else>
                <div class="badge-grid-empty">
                    <p>No games completed yet. Complete a game to see your history.</p>
                </div>
            </g:else>

            <g:if test="${model?.pendingTests}">
                <div class="pending-tests-container">
                    <h4>Available Games</h4>
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
                </div>
            </g:if>
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
                                <div class="sd-head"><span>Logic</span> <span style="${logicPct == 0 ? 'font-size: 0.85rem; opacity: 0.9;' : ''}">${logicPct > 0 ? logicPct.toInteger() + '%' : 'Developing'}</span></div>
                                <div class="sd-track">
                                    <div class="sd-fill" style="width: ${logicPct > 8 ? logicPct : 8}%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="skill-row">
                            <div class="skill-icon">🗣️</div>
                            <div class="skill-data">
                                <div class="sd-head"><span>Verbal</span> <span style="${verbalPct == 0 ? 'font-size: 0.85rem; opacity: 0.9;' : ''}">${verbalPct > 0 ? verbalPct.toInteger() + '%' : 'Developing'}</span></div>
                                <div class="sd-track">
                                    <div class="sd-fill" style="width: ${verbalPct > 8 ? verbalPct : 8}%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="skill-row">
                            <div class="skill-icon">📐</div>
                            <div class="skill-data">
                                <div class="sd-head"><span>Spatial</span> <span style="${spatialPct == 0 ? 'font-size: 0.85rem; opacity: 0.9;' : ''}">${spatialPct > 0 ? spatialPct.toInteger() + '%' : 'Developing'}</span></div>
                                <div class="sd-track">
                                    <div class="sd-fill" style="width: ${spatialPct > 8 ? spatialPct : 8}%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="skill-row">
                            <div class="skill-icon">⚡</div>
                            <div class="skill-data">
                                <div class="sd-head"><span>Speed</span> <span style="${speedPct == 0 ? 'font-size: 0.85rem; opacity: 0.9;' : ''}">${speedPct > 0 ? speedPct.toInteger() + '%' : 'Developing'}</span></div>
                                <div class="sd-track">
                                    <div class="sd-fill" style="width: ${speedPct > 8 ? speedPct : 8}%"></div>
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
                <g:each in="${suggestedStreams}" var="stream" status="i">
                    <div class="stream-card ${stream.isBest ? 'hero-card' : ''}">
                        <div class="sc-match-tag ${stream.isBest ? 'best' : ''}">
                            ${stream.match}% Match ${stream.isBest ? '• Best Fit' : ''}
                        </div>
                        <div class="sc-main-content">
                            <div class="sc-icon">${stream.icon}</div>
                            <div class="sc-title">${stream.title}</div>
                            <div class="sc-desc">${stream.engagingDescription}</div>
                            <div class="sc-power">
                                <span>${stream.ultimatePower}</span>
                            </div>
                            <div class="sc-action">
                                <button class="sc-toggle-btn" data-target="collapsible-stream-${i}">Learn More</button>
                            </div>
                        </div>
                        <div class="sc-collapsible-content" id="collapsible-stream-${i}">
                            <div class="sc-detail-block">
                                <h4>Your Strengths</h4>
                                <p>${raw(stream.personalizedRationale)}</p>
                            </div>
                            <div class="sc-detail-block">
                                <h4>Your First Quest</h4>
                                <p>${raw(stream.firstQuest)}</p>
                            </div>
                            <div class="sc-detail-block">
                                <h4>Level Up Your Skills</h4>
                                <p>${stream.levelUp}</p>
                            </div>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>

        <g:if test="${completedGames >= totalGames}">
            <div class="glass-panel area-next anim-pop d-3">
                <div class="panel-label">Your Next Step${model.nextSteps?.size() > 1 ? 's' : ''}</div>
                <g:if test="${model.nextSteps}">
                    <div class="next-steps-container" style="display: flex; flex-direction: column; gap: 0px;">
                        <g:each in="${model.nextSteps}" var="step">
                            <div class="next-step-card-link" style="cursor: default;">
                                <div class="next-step-content-v2">
                                    <div class="next-step-icon">${step.icon}</div>
                                    <div class="next-step-text">
                                        <h4>${step.title}</h4>
                                        <p>${step.suggestion}</p>
                                    </div>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </g:if>
                <g:else>
                    <div class="next-steps-list" style="text-align: center; padding: 16px;">
                        <p>Complete the Brain Power game to unlock your personalized next step!</p>
                    </div>
                </g:else>
            </div>
        </g:if>

        <g:if test="${completedGames >= totalGames}">
            <div class="glass-panel area-share anim-pop d-3">
                <div class="share-section-title" style="text-align:center; font-family:Fredoka,sans-serif; font-weight:700; font-size:1.1rem; color:#5D4037; margin:0 0 0px; opacity:1;">SHARE YOUR LEARNING DNA!</div>
                <div class="share-section-title" style="text-align:center; font-family:Fredoka,sans-serif; font-weight:700; font-size:1.1rem; color:#5D4037; margin:0 0 15px; opacity:1;">Challenge your friends to discover theirs!</div>
                <div class="share-buttons-row">
                    <div class="share-btn-large" style="background: #1DA1F2" onclick="shareOnTwitter()" title="Share on Twitter"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"/></svg></div>
                    <div class="share-btn-large" style="background: #25D366" onclick="shareOnWhatsApp()" title="Share on WhatsApp"><svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path d="M20.52 3.48A11.77 11.77 0 0 0 12.02 0C5.39.04.08 5.35.08 12c0 2.11.55 4.14 1.59 5.95L0 24l6.2-1.62A11.9 11.9 0 0 0 12 24c6.63 0 12-5.37 12-12 0-3.2-1.25-6.21-3.48-8.52zM12 22a9.9 9.9 0 0 1-5.04-1.39l-.36-.21-3.68.96.98-3.58-.24-.37A9.91 9.91 0 1 1 12 22zm5.43-7.45c-.3-.15-1.78-.88-2.06-.97-.28-.1-.48-.15-.69.15-.2.3-.79.97-.97 1.17-.18.2-.36.22-.66.07-.3-.15-1.27-.47-2.42-1.5-.89-.79-1.49-1.76-1.67-2.06-.17-.3-.02-.46.13-.61.13-.13.3-.33.45-.5.15-.17.2-.29.3-.49.1-.2.05-.37-.02-.52-.07-.15-.69-1.65-.95-2.26-.25-.6-.5-.52-.69-.53h-.59c-.2 0-.52..07-.79.37s-1.04 1.02-1.04 2.49 1.07 2.89 1.22 3.09c.15.2 2.1 3.2 5.1 4.49.71.31 1.26.5 1.69.64.71.23 1.36.2 1.87.12.57-.08 1.78-.73 2.03-1.44.25-.71.25-1.32.17-1.44-.08-.12-.27-.2-.57-.35z"/></svg></div>
                    <div class="share-btn-large" style="background: #E1306C" onclick="shareOnInstagram()" title="Share on Instagram"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg></div>
                    <div class="share-btn-large" style="background: #0077B5" onclick="shareOnLinkedIn()" title="Share on LinkedIn"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg></div>
                    <div class="share-btn-large" style="background: #6c5ce7" onclick="copyToClipboard()" title="Copy link to clipboard"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="10" height="12" rx="2"></rect><rect x="5" y="5" width="10" height="12" rx="2"></rect></svg></div>
                </div>
                <div class="share-labels">
                    <span>Twitter</span>
                    <span>WhatsApp</span>
                    <span>Instagram</span>
                    <span>LinkedIn</span>
                    <span>Copy</span>
                </div>
            </div>
        </g:if>

    </div>

    <g:if test="${completedGames >= totalGames}">
        <div style="text-align: center; margin-top: 20px; color: var(--text-dark); opacity: 0.8; font-weight: 600; font-size: 1.1rem; font-family: var(--font-display);"
             class="anim-pop d-3">
            Your potential is mapped. Trust your unique strengths.
        </div>
    </g:if>

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

        // Stream card toggle functionality
        const toggleButtons = document.querySelectorAll('.sc-toggle-btn');
        toggleButtons.forEach(button => {
            button.addEventListener('click', () => {
                const targetId = button.dataset.target;
                const targetContent = document.getElementById(targetId);
                if (targetContent) {
                    const isExpanded = targetContent.classList.contains('expanded');
                    if (isExpanded) {
                        targetContent.classList.remove('expanded');
                        button.textContent = 'Learn More';
                    } else {
                        targetContent.classList.add('expanded');
                        button.textContent = 'Show Less';
                    }
                }
            });
        });
    });

    // Sharing functions
    function getShareData() {
        // 1. Scrape the result from the UI
        const titleEl = document.querySelector('.animal-title');
        let animalName = "a Unique Thinker";
        
        if (titleEl) {
            // Text is usually "You are THE STRATEGIC WOLF!" -> extract "THE STRATEGIC WOLF"
            let text = titleEl.innerText || titleEl.textContent;
            // Remove "You are " and punctuation
            text = text.replace(/You are /i, '').replace(/[!.]/g, '').trim();
            if (text && text !== 'Discover Your Inner Spark') {
                animalName = text;
            }
        }

        // 2. Point to Home Page (Viral Loop) - New users start here
        const shareUrl = window.location.origin; 

        return {
            name: animalName,
            url: shareUrl
        };
    }

    function shareOnTwitter() {
        const data = getShareData();
        const text = "I just discovered I'm " + data.name + " on learnerDNA! 🦉 My superpower is unique. What is your Learning DNA? Find out here:";
        window.open('https://twitter.com/intent/tweet?text=' + encodeURIComponent(text) + '&url=' + encodeURIComponent(data.url), '_blank');
    }
    function shareOnWhatsApp() {
        const data = getShareData();
        const text = "I just discovered I'm " + data.name + " on learnerDNA! 🦉 My superpower is unique. What is your Learning DNA? Find out here: " + data.url;
        if (/Android|iPhone|iPad|iPod/i.test(navigator.userAgent)) {
            window.location.href = 'whatsapp://send?text=' + encodeURIComponent(text);
        } else {
            window.open('https://wa.me/?text=' + encodeURIComponent(text), '_blank');
        }
    }
    function shareOnInstagram() {
        const data = getShareData();
        const caption = "I just discovered I'm " + data.name + " on learnerDNA! 🦉 What is your Learning DNA? @learnerDNA";
        
        // Instagram Strategy: Copy Caption + Prompt for Screenshot
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(caption).then(function() {
                alert("Caption copied! 📸\n\n1. Take a screenshot of your badge.\n2. Post it to your Story.\n3. Paste this caption!");
            }).catch(function() {
                alert("Take a screenshot of your badge and share it on your Story!");
            });
        } else {
            alert("Take a screenshot of your badge and share it on your Story!");
        }
    }
    function shareOnLinkedIn() {
        const data = getShareData();
        window.open('https://www.linkedin.com/sharing/share-offsite/?url=' + encodeURIComponent(data.url), '_blank');
    }
    function copyToClipboard(message) {
        const data = getShareData();
        const textToCopy = "I just discovered I'm " + data.name + " on learnerDNA! 🦉 What is your Learning DNA? Find out here: " + data.url;
        
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(textToCopy).then(function() {
                alert(message || '✅ Result & Link copied to clipboard!');
            }).catch(function() {
                fallbackCopy(textToCopy, message);
            });
        } else {
            fallbackCopy(textToCopy, message);
        }
    }
    function fallbackCopy(text, message) {
        var t = document.createElement('textarea');
        t.value = text;
        t.style.position = 'fixed';
        t.style.left = '-9999px';
        document.body.appendChild(t);
        t.select();
        try {
            document.execCommand('copy');
            alert(message || '✅ Link copied to clipboard!');
        } catch(e) {
            prompt('Copy this link:', text);
        }
        document.body.removeChild(t);
    }
</script>
</body>
