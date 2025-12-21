<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Test Results - StreamFit</title>
    <style>
        .results-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        /* Reward Modal */
        .reward-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .reward-content {
            background: white;
            border-radius: 24px;
            padding: 50px;
            max-width: 500px;
            text-align: center;
            animation: scaleIn 0.5s ease;
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
            margin-bottom: 20px;
            animation: bounce 1s ease infinite;
        }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }
        
        .reward-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: #333;
        }
        
        .reward-points {
            font-size: 3rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
        }
        
        .reward-badges {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 30px 0;
        }
        
        .badge-item {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 15px;
            min-width: 100px;
        }
        
        .badge-emoji {
            font-size: 3rem;
            margin-bottom: 10px;
        }
        
        .badge-name {
            font-size: 0.9rem;
            color: #666;
        }
        
        .level-up {
            background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
        }
        
        .level-up-text {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
        }
        
        .continue-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.3s ease;
        }
        
        .continue-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 24px rgba(102, 126, 234, 0.4);
        }
        
        /* Results Card */
        .result-card {
            background: white;
            border-radius: 16px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .result-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .result-emoji {
            font-size: 5rem;
            margin-bottom: 20px;
        }
        
        .result-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: #333;
        }
        
        .result-summary {
            font-size: 1.2rem;
            color: #666;
            line-height: 1.6;
        }
        
        .result-section {
            margin: 30px 0;
        }
        
        .result-section h3 {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: #333;
        }
        
        .result-section p {
            font-size: 1.1rem;
            color: #666;
            line-height: 1.8;
        }
        
        .score-breakdown {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        
        .score-item {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
        }
        
        .score-label {
            font-size: 0.9rem;
            color: #888;
            margin-bottom: 10px;
        }
        
        .score-value {
            font-size: 2rem;
            font-weight: 700;
            color: #667eea;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            flex: 1;
            padding: 15px;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-secondary {
            background: #f8f9fa;
            color: #333;
            border: 2px solid #e0e0e0;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>
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
                const response = await fetch(`/api/diagnostic/result/${'$'}{sessionId}`);
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
            document.getElementById('reward-points').textContent = `+${'$'}{rewards.points} Points`;

            // Show level up if applicable
            if (rewards.leveledUp) {
                document.getElementById('level-up-container').innerHTML = `
                    <div class="level-up">
                        <div class="level-up-text">🎊 Level Up! You're now Level ${'$'}{rewards.newLevel}!</div>
                    </div>
                `;
            }
            
            // Show badges
            if (rewards.badges && rewards.badges.length > 0) {
                document.getElementById('reward-badges').innerHTML = rewards.badges.map(badge => `
                    <div class="badge-item">
                        <div class="badge-emoji">${'$'}{badge.emoji}</div>
                        <div class="badge-name">${'$'}{badge.badgeName}</div>
                    </div>
                `).join('');
            }

            // Show achievements
            if (rewards.achievements && rewards.achievements.length > 0) {
                document.getElementById('achievements-container').innerHTML = `
                    <div style="margin-top: 20px;">
                        <h3 style="margin-bottom: 15px;">🏆 New Achievements!</h3>
                        ${'$'}{rewards.achievements.map(ach => `
                            <div style="background: #f8f9fa; border-radius: 8px; padding: 15px; margin: 10px 0;">
                                <div style="font-size: 2rem;">${'$'}{ach.emoji}</div>
                                <div style="font-weight: 600; margin-top: 5px;">${'$'}{ach.achievementTitle}</div>
                                <div style="color: #666; font-size: 0.9rem;">${'$'}{ach.achievementDescription}</div>
                            </div>
                        `).join('')}
                    </div>
                `;
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

