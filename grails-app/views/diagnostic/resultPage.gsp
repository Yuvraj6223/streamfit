<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Test Results - StreamFit</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
    :root {
        /* BRAND PALETTE - SOFT POP */
        --bg-warm: #FDFCF8;
        --text-dark: #1A1825;
        --text-grey: #8E8C9A;

        /* VITAMIN COLORS */
        --pop-coral: #FF8F7D;
        --pop-purple: #9F97F3;
        --pop-teal: #73D2DE;
        --pop-yellow: #FFD86D;
        --pop-cream: #FFF4F0;

        /* SURFACES */
        --card-base: #FFFFFF;
        /* CLAYMORPHISM SHADOWS */
        --shadow-soft: 0 12px 30px -10px rgba(28, 26, 40, 0.04);
        --shadow-float: 0 20px 40px -12px rgba(159, 151, 243, 0.2);

        /* ANIMATION */
        --ease-elastic: cubic-bezier(0.34, 1.56, 0.64, 1);
        --ease-smooth: cubic-bezier(0.16, 1, 0.3, 1);
    }

    body {
        font-family: 'Plus Jakarta Sans', sans-serif;
        background-color: var(--bg-warm);
        color: var(--text-dark);
        margin: 0;
        min-height: 100vh;
        overflow-x: hidden;
        -webkit-font-smoothing: antialiased;
    }

    /* --- AMBIENT BACKGROUND --- */
    .scenery-layer {
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        z-index: -1;
        overflow: hidden;
        background: var(--bg-warm);
    }
    .blob {
        position: absolute;
        filter: blur(80px);
        opacity: 0.5;
        animation: float-blob 20s infinite ease-in-out alternate;
    }
    .b-1 { top: -10%; right: -5%; width: 600px; height: 600px;
        background: var(--pop-purple); border-radius: 40% 60% 70% 30%; }
    .b-2 { bottom: -10%; left: -10%; width: 700px;
        height: 700px; background: var(--pop-teal); border-radius: 60% 40% 30% 70%; animation-delay: -5s; }
    .b-3 { top: 40%;
        left: 40%; width: 400px; height: 400px; background: var(--pop-coral); opacity: 0.3; border-radius: 30% 70%; animation-duration: 18s;
    }

    @keyframes float-blob {
        0% { transform: translate(0, 0) rotate(0deg); }
        100% { transform: translate(40px, 40px) rotate(10deg); }
    }

    .results-container {
        max-width: 900px;
        margin: 0 auto;
        padding: 40px 24px;
        position: relative;
        z-index: 1;
    }

    /* --- REWARD MODAL --- */
    .reward-modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(26, 24, 37, 0.85);
        backdrop-filter: blur(10px);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
        animation: fadeIn 0.3s var(--ease-smooth);
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .reward-content {
        background: var(--card-base);
        border-radius: 32px;
        padding: 60px 50px;
        max-width: 550px;
        text-align: center;
        animation: scaleIn 0.5s var(--ease-elastic);
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.5);
    }

    @keyframes scaleIn {
        from {
            transform: scale(0.8);
            opacity: 0;
        }
        to {
            transform: scale(1);
            opacity: 1;
        }
    }

    .reward-emoji {
        font-size: 6rem;
        margin-bottom: 24px;
        animation: bounce 1s ease infinite;
    }

    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-20px); }
    }

    .reward-title {
        font-size: 2.2rem;
        font-weight: 800;
        margin-bottom: 20px;
        color: var(--text-dark);
        letter-spacing: -0.02em;
    }

    .reward-points {
        font-size: 3.5rem;
        font-weight: 800;
        background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 24px;
    }

    .reward-badges {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin: 32px 0;
        flex-wrap: wrap;
    }

    .badge-item {
        background: linear-gradient(135deg, var(--pop-cream) 0%, white 100%);
        border-radius: 20px;
        padding: 20px;
        min-width: 110px;
        box-shadow: var(--shadow-soft);
        transition: all 0.3s var(--ease-elastic);
    }

    .badge-item:hover {
        transform: translateY(-5px) scale(1.05);
        box-shadow: var(--shadow-float);
    }

    .badge-emoji {
        font-size: 3rem;
        margin-bottom: 12px;
    }

    .badge-name {
        font-size: 0.9rem;
        color: var(--text-grey);
        font-weight: 700;
    }

    .level-up {
        background: linear-gradient(135deg, var(--pop-yellow) 0%, #FFE89D 100%);
        border-radius: 20px;
        padding: 24px;
        margin: 24px 0;
        box-shadow: var(--shadow-float);
    }

    .level-up-text {
        font-size: 1.6rem;
        font-weight: 800;
        color: var(--text-dark);
        letter-spacing: -0.01em;
    }

    .continue-btn {
        background: var(--text-dark);
        color: white;
        border: none;
        padding: 18px 48px;
        border-radius: 100px;
        font-size: 1.1rem;
        font-weight: 700;
        cursor: pointer;
        margin-top: 24px;
        transition: all 0.3s var(--ease-elastic);
        box-shadow: var(--shadow-float);
        font-family: inherit;
    }

    .continue-btn:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 25px 50px -12px rgba(159, 151, 243, 0.4);
    }

        /* --- RESULTS CARD --- */
        .result-card {
            background: var(--card-base);
            border-radius: 32px;
            padding: 50px 40px;
            margin-bottom: 40px;
            box-shadow: var(--shadow-float);
            border: 1px solid rgba(255,255,255,0.5);
        }

        .result-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .result-emoji {
            font-size: 5rem;
            margin-bottom: 24px;
            animation: float-blob 3s infinite ease-in-out alternate;
        }

        .result-title {
            font-size: clamp(2rem, 5vw, 3rem);
            font-weight: 800;
            margin-bottom: 20px;
            color: var(--text-dark);
            letter-spacing: -0.03em;
            line-height: 1.2;
        }

        .result-summary {
            font-size: 1.25rem;
            color: var(--text-grey);
            line-height: 1.7;
            font-weight: 600;
        }

        .result-section {
            margin: 40px 0;
            padding: 32px;
            background: linear-gradient(135deg, var(--pop-cream) 0%, white 100%);
            border-radius: 24px;
            border: 1px solid rgba(255,255,255,0.5);
            transition: all 0.3s var(--ease-elastic);
        }

        .result-section:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-soft);
        }

        .result-section h3 {
            font-size: 1.6rem;
            margin-bottom: 20px;
            color: var(--text-dark);
            font-weight: 800;
            letter-spacing: -0.02em;
        }

        .result-section p {
            font-size: 1.1rem;
            color: var(--text-grey);
            line-height: 1.8;
            font-weight: 500;
            margin: 0;
        }

        .score-breakdown {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 24px 0;
        }

        .score-item {
            background: white;
            border-radius: 20px;
            padding: 24px;
            text-align: center;
            box-shadow: var(--shadow-soft);
            transition: all 0.3s var(--ease-elastic);
        }

        .score-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-float);
        }

        .score-label {
            font-size: 0.9rem;
            color: var(--text-grey);
            margin-bottom: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .score-value {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .action-buttons {
            display: flex;
            gap: 16px;
            margin-top: 40px;
        }

        .btn {
            flex: 1;
            padding: 18px 32px;
            border-radius: 100px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            border: none;
            transition: all 0.3s var(--ease-elastic);
            font-family: inherit;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary {
            background: var(--text-dark);
            color: white;
            box-shadow: var(--shadow-float);
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 25px 50px -12px rgba(159, 151, 243, 0.4);
        }

        .btn-secondary {
            background: white;
            color: var(--text-dark);
            border: 2px solid #F0F0F5;
            box-shadow: var(--shadow-soft);
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            border-color: var(--pop-purple);
            box-shadow: var(--shadow-float);
        }

        /* --- ANIMATIONS --- */
        @keyframes reveal {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-in {
            opacity: 0;
            animation: reveal 0.8s var(--ease-smooth) forwards;
        }

        /* --- RESPONSIVE --- */
        @media (max-width: 768px) {
            .results-container {
                padding: 30px 16px;
            }

            .reward-content {
                padding: 40px 30px;
                max-width: 90%;
            }

            .result-card {
                padding: 40px 24px;
            }

            .result-section {
                padding: 24px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- Ambient Background -->
<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

    <!-- Reward Modal (shown first) -->
    <div id="reward-modal" class="reward-modal">
        <div class="reward-content">
            <div class="reward-emoji">🎉</div>
            <div class="reward-title">Test Completed!</div>
            <div class="reward-points" id="reward-points">+50 Points</div>
            
            <div id="level-up-container"></div>
            
            <div class="reward-badges" id="reward-badges"></div>
            
            <div id="achievements-container"></div>
            
            <button class="continue-btn" onclick="closeRewardModal()">
                See Your Results →
            </button>
        </div>
    </div>
    
    <!-- Results Content (hidden initially) -->
    <div class="results-container" id="results-content" style="display: none;">
        <div class="result-card">
            <div class="result-header">
                <div class="result-emoji" id="result-emoji">🦉</div>
                <div class="result-title" id="result-title">Loading...</div>
                <div class="result-summary" id="result-summary"></div>
            </div>
            
            <div class="result-section">
                <h3>📊 Your Profile</h3>
                <p id="result-profile"></p>
            </div>
            
            <div class="result-section">
                <h3>💪 Your Strengths</h3>
                <p id="result-strengths"></p>
            </div>
            
            <div class="result-section" id="traps-section">
                <h3>⚠️ Watch Out For</h3>
                <p id="result-traps"></p>
            </div>
            
            <div class="result-section">
                <h3>🎯 AI Roadmap</h3>
                <p id="result-roadmap"></p>
            </div>
            
            <div class="result-section" id="matches-section">
                <h3>🎓 Best Matches</h3>
                <p id="result-matches"></p>
            </div>
            
            <div class="action-buttons">
                <button class="btn btn-secondary" onclick="window.location.href='/diagnostic'">
                    Take Another Test
                </button>
                <button class="btn btn-primary" onclick="window.location.href='/dashboard'">
                    View Dashboard
                </button>
            </div>
        </div>
    </div>
    
    <script>
        const sessionId = '${result.sessionId}';
        
        async function loadResults() {
            try {
                const response = await fetch('/api/diagnostic/result/' + sessionId);
                const data = await response.json();
                
                if (data.success) {
                    displayResults(data);
                } else {
                    alert('Failed to load results');
                }
            } catch (error) {
                console.error('Error loading results:', error);
            }
        }
        
        function displayResults(data) {
            // Display rewards first
            displayRewards(data.rewards);
            
            // Populate results
            document.getElementById('result-emoji').textContent = data.emoji || '🎯';
            document.getElementById('result-title').textContent = data.resultTitle;
            document.getElementById('result-summary').textContent = data.resultSummary;
            document.getElementById('result-profile').textContent = data.profile || '';
            document.getElementById('result-strengths').textContent = data.strengths || '';
            document.getElementById('result-traps').textContent = data.traps || '';
            document.getElementById('result-roadmap').textContent = data.aiRoadmap || '';
            document.getElementById('result-matches').textContent = data.bestMatches || '';
            
            // Hide sections if no data
            if (!data.traps) {
                document.getElementById('traps-section').style.display = 'none';
            }
            if (!data.bestMatches) {
                document.getElementById('matches-section').style.display = 'none';
            }
        }
        
        function displayRewards(rewards) {
            if (!rewards) return;
            
            // Update points
            document.getElementById('reward-points').textContent = '+' + rewards.points + ' Points';

            // Show level up if applicable
            if (rewards.leveledUp) {
                document.getElementById('level-up-container').innerHTML =
                    '<div class="level-up">' +
                        '<div class="level-up-text">🎊 Level Up! You\'re now Level ' + rewards.newLevel + '!</div>' +
                    '</div>';
            }

            // Show badges
            if (rewards.badges && rewards.badges.length > 0) {
                var badgesHtml = rewards.badges.map(function(badge) {
                    return '<div class="badge-item">' +
                        '<div class="badge-emoji">' + badge.emoji + '</div>' +
                        '<div class="badge-name">' + badge.badgeName + '</div>' +
                    '</div>';
                }).join('');
                document.getElementById('reward-badges').innerHTML = badgesHtml;
            }

            // Show achievements
            if (rewards.achievements && rewards.achievements.length > 0) {
                var achievementsHtml = '<div style="margin-top: 20px;">' +
                    '<h3 style="margin-bottom: 15px;">🏆 New Achievements!</h3>';

                rewards.achievements.forEach(function(ach) {
                    achievementsHtml += '<div style="background: #f8f9fa; border-radius: 8px; padding: 15px; margin: 10px 0;">' +
                        '<div style="font-size: 2rem;">' + ach.emoji + '</div>' +
                        '<div style="font-weight: 600; margin-top: 5px;">' + ach.achievementTitle + '</div>' +
                        '<div style="color: #666; font-size: 0.9rem;">' + ach.achievementDescription + '</div>' +
                    '</div>';
                });

                achievementsHtml += '</div>';
                document.getElementById('achievements-container').innerHTML = achievementsHtml;
            }
        }
        
        function closeRewardModal() {
            document.getElementById('reward-modal').style.display = 'none';
            document.getElementById('results-content').style.display = 'block';
        }
        
        // Load results on page load
        document.addEventListener('DOMContentLoaded', loadResults);
    </script>
</body>
</html>

