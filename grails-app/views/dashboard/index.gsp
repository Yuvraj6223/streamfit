<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Learning DNA Dashboard - StreamFit</title>
    <style>
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        .dashboard-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            box-shadow: 0 8px 24px rgba(102, 126, 234, 0.3);
        }
        
        .dashboard-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .dashboard-header p {
            font-size: 1.2rem;
            opacity: 0.95;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: #667eea;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 1rem;
            color: #666;
        }
        
        .section {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #333;
        }
        
        .test-results-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .test-result-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            border-left: 4px solid #667eea;
        }
        
        .test-result-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 10px;
        }
        
        .test-result-name {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
        }
        
        .test-result-type {
            font-size: 0.8rem;
            padding: 4px 12px;
            border-radius: 12px;
            background: #667eea;
            color: white;
        }
        
        .test-result-title {
            font-size: 1.1rem;
            color: #667eea;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .test-result-date {
            font-size: 0.9rem;
            color: #888;
        }
        
        .badges-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 15px;
        }
        
        .badge-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .badge-card:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        
        .badge-card.new::after {
            content: 'NEW!';
            position: absolute;
            top: 10px;
            right: 10px;
            background: #ff4757;
            color: white;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 0.7rem;
            font-weight: 700;
        }
        
        .badge-emoji {
            font-size: 3rem;
            margin-bottom: 10px;
        }
        
        .badge-name {
            font-size: 0.9rem;
            font-weight: 600;
            color: #333;
        }
        
        .badge-rarity {
            font-size: 0.8rem;
            color: #888;
            margin-top: 5px;
        }
        
        .achievements-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        .achievement-item {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .achievement-emoji {
            font-size: 3rem;
        }
        
        .achievement-content {
            flex: 1;
        }
        
        .achievement-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        
        .achievement-description {
            font-size: 0.9rem;
            color: #666;
        }
        
        .achievement-points {
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
        }
        
        .progress-section {
            margin-bottom: 30px;
        }
        
        .progress-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 1rem;
            color: #666;
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
        
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #888;
        }
        
        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 15px;
        }
        
        .cta-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.3s ease;
        }
        
        .cta-button:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1>🧬 Your Learning DNA</h1>
            <p id="welcome-text">Welcome back! Here's your personalized learning profile.</p>
        </div>
        
        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">🎯</div>
                <div class="stat-value" id="stat-tests">0</div>
                <div class="stat-label">Tests Completed</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">⭐</div>
                <div class="stat-value" id="stat-level">1</div>
                <div class="stat-label">Current Level</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">💎</div>
                <div class="stat-value" id="stat-points">0</div>
                <div class="stat-label">Total Points</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">🔥</div>
                <div class="stat-value" id="stat-streak">0</div>
                <div class="stat-label">Day Streak</div>
            </div>
        </div>
        
        <!-- Level Progress -->
        <div class="section">
            <div class="progress-section">
                <div class="progress-label">
                    <span>Level <span id="current-level">1</span></span>
                    <span><span id="points-to-next">100</span> points to next level</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" id="level-progress" style="width: 0%"></div>
                </div>
            </div>
        </div>
        
        <!-- Test Results -->
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">📊 Your Test Results</h2>
            </div>
            <div class="test-results-grid" id="test-results">
                <div class="empty-state">
                    <div class="empty-state-icon">📝</div>
                    <p>No tests completed yet</p>
                    <button class="cta-button" onclick="window.location.href='/diagnostic'">
                        Take Your First Test
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Badges -->
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">🏅 Badges Earned</h2>
                <span id="badge-count">0 badges</span>
            </div>
            <div class="badges-grid" id="badges-grid">
                <div class="empty-state">
                    <div class="empty-state-icon">🏅</div>
                    <p>Complete tests to earn badges!</p>
                </div>
            </div>
        </div>
        
        <!-- Achievements -->
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">🏆 Achievements</h2>
                <span id="achievement-count">0 achievements</span>
            </div>
            <div class="achievements-list" id="achievements-list">
                <div class="empty-state">
                    <div class="empty-state-icon">🏆</div>
                    <p>Unlock achievements by completing milestones!</p>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        async function loadDashboard() {
            try {
                const response = await fetch('/api/dashboard/data');
                const data = await response.json();
                
                if (data.success) {
                    displayDashboard(data);
                }
            } catch (error) {
                console.error('Error loading dashboard:', error);
            }
        }
        
        function displayDashboard(data) {
            // Update welcome text
            document.getElementById('welcome-text').textContent =
                `Welcome back, ${'$'}{data.user.name}! Here's your personalized learning profile.`;
            
            // Update stats
            document.getElementById('stat-tests').textContent = data.stats.totalTestsCompleted;
            document.getElementById('stat-level').textContent = data.stats.currentLevel;
            document.getElementById('stat-points').textContent = data.stats.totalPoints;
            document.getElementById('stat-streak').textContent = data.stats.currentStreak;
            
            // Update level progress
            document.getElementById('current-level').textContent = data.stats.currentLevel;
            document.getElementById('points-to-next').textContent = data.stats.pointsToNextLevel;
            
            const levelProgress = ((data.stats.totalPoints % 100) / 100) * 100;
            document.getElementById('level-progress').style.width = `${'$'}{levelProgress}%`;
            
            // Display test results
            if (data.testResults && data.testResults.length > 0) {
                displayTestResults(data.testResults);
            }
            
            // Display badges
            if (data.badges && data.badges.length > 0) {
                displayBadges(data.badges);
            }
            
            // Display achievements
            if (data.achievements && data.achievements.length > 0) {
                displayAchievements(data.achievements);
            }
        }
        
        function displayTestResults(results) {
            const container = document.getElementById('test-results');
            container.innerHTML = results.map(result => `
                <div class="test-result-card">
                    <div class="test-result-header">
                        <div class="test-result-name">${'$'}{result.testName}</div>
                        <div class="test-result-type">${'$'}{result.testType}</div>
                    </div>
                    <div class="test-result-title">${'$'}{result.resultTitle}</div>
                    <div class="test-result-date">
                        Completed ${'$'}{new Date(result.completedAt).toLocaleDateString()}
                    </div>
                </div>
            `).join('');
        }
        
        function displayBadges(badges) {
            document.getElementById('badge-count').textContent = `${'$'}{badges.length} badge${'$'}{badges.length !== 1 ? 's' : ''}`;

            const container = document.getElementById('badges-grid');
            container.innerHTML = badges.map(badge => `
                <div class="badge-card ${'$'}{badge.isNew ? 'new' : ''}">
                    <div class="badge-emoji">${'$'}{badge.emoji}</div>
                    <div class="badge-name">${'$'}{badge.badgeName}</div>
                    <div class="badge-rarity">${'$'}{badge.rarity}</div>
                </div>
            `).join('');
        }
        
        function displayAchievements(achievements) {
            document.getElementById('achievement-count').textContent =
                `${'$'}{achievements.length} achievement${'$'}{achievements.length !== 1 ? 's' : ''}`;

            const container = document.getElementById('achievements-list');
            container.innerHTML = achievements.map(ach => `
                <div class="achievement-item">
                    <div class="achievement-emoji">${'$'}{ach.emoji}</div>
                    <div class="achievement-content">
                        <div class="achievement-title">${'$'}{ach.achievementTitle}</div>
                        <div class="achievement-description">${'$'}{ach.achievementDescription}</div>
                    </div>
                    <div class="achievement-points">+${'$'}{ach.pointsAwarded}</div>
                </div>
            `).join('');
        }
        
        document.addEventListener('DOMContentLoaded', loadDashboard);
    </script>
</body>
</html>

