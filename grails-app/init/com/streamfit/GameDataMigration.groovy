package com.streamfit

import com.streamfit.service.*
import grails.gorm.transactions.Transactional
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper

@Transactional
class GameDataMigration {

    def migrateAllGameData() {
        println "Starting game data migration..."
        
        // Clear existing data
        GameQuestion.executeUpdate("delete from GameQuestion")
        GameOption.executeUpdate("delete from GameOption") 
        OptionPersonaMapping.executeUpdate("delete from OptionPersonaMapping")
        
        // Migrate each game
        migrateCognitiveRadar()
        migrateCuriosityCompass()
        migrateFocusStamina()
        migrateGuessworkQuotient()
        migrateModalityMap()
        migratePatternSnapshot()
        migrateSpiritAnimal()
        migrateWorkMode()
        migratePersonality()
        
        println "Game data migration completed!"
    }
    
    void migrateCognitiveRadar() {
        println "Migrating Cognitive Radar..."
        
        // Questions from CognitiveRadarService
        def questions = [
            [number: 1, text: 'If Glimp is always bigger than Glump', dimension: 'LOGIC', type: 'MULTIPLE_CHOICE'],
            [number: 2, text: 'You see a pattern forming what comes next', dimension: 'LOGIC', type: 'MULTIPLE_CHOICE'],
            [number: 3, text: 'What is the opposite word of STAGNANT', dimension: 'VERBAL', type: 'MULTIPLE_CHOICE'],
            [number: 4, text: 'Theory is so blank that critics cannot blank', dimension: 'VERBAL', type: 'MULTIPLE_CHOICE'],
            [number: 5, text: 'A cube rotates right and then flips down', dimension: 'SPATIAL', type: 'MULTIPLE_CHOICE'],
            [number: 6, text: 'Count how many times letter E appears', dimension: 'SPEED', type: 'TIMED', timeLimit: 5]
        ]
        
        def optionsData = [
            1: [[text: '✅ Glamp bigger than Glimp', value: 'YES', correct: false], 
                [text: '❌ Can never tell', value: 'NO', correct: true]],
            2: [[text: '40', value: '40', correct: false], 
                [text: '42', value: '42', correct: true]],
            3: [[text: '😐 Calm', value: 'CALM', correct: false], 
                [text: '🌊 Flowing', value: 'FLOWING', correct: true],
                [text: '🤫 Silent', value: 'SILENT', correct: false]],
            4: [[text: '😐 Simple... Understand', value: 'SIMPLE_UNDERSTAND', correct: false], 
                [text: '🔥 Compelling... Refute', value: 'COMPELLING_REFUTE', correct: true]],
            5: [[text: '⬇️ Bottom face', value: 'BOTTOM', correct: true], 
                [text: '➡️ Right face', value: 'RIGHT', correct: false],
                [text: '⏩ Front face', value: 'FRONT', correct: false]],
            6: [[text: '4', value: '4', correct: false], 
                [text: '5', value: '5', correct: false],
                [text: '6', value: '6', correct: true],
                [text: '7', value: '7', correct: false]]
        ]
        
        questions.each { qData ->
            def question = new GameQuestion(
                questionId: "COGNITIVE_RADAR_Q${qData.number}",
                gameType: 'COGNITIVE_RADAR',
                questionNumber: qData.number,
                questionText: qData.text,
                questionType: qData.type,
                scoringDimension: qData.dimension,
                timeLimit: qData.timeLimit
            ).save(flush: true)
            
            optionsData[qData.number].eachWithIndex { opt, index ->
                def option = new GameOption(
                    question: question,
                    optionText: opt.text,
                    optionValue: opt.value,
                    displayOrder: index + 1,
                    isCorrect: opt.correct
                ).save(flush: true)
                
                // Create persona mappings based on dimension
                createPersonaMapping(option, qData.dimension)
            }
        }
    }
    
    void migrateCuriosityCompass() {
        println "Migrating Curiosity Compass..."
        
        def questions = [
            [number: 1, text: 'You see a documentary about ancient civilizations'],
            [number: 2, text: 'You hear about a new science experiment'],
            [number: 3, text: 'You are reading an article right now'],
            [number: 4, text: 'You are in a debate right now'],
            [number: 5, text: 'Which teacher style works best for you'],
            [number: 6, text: 'Most frustrating thing when you are learning']
        ]
        
        def optionsData = [
            1: [['🧠 How society evolved', 'A'], ['🔨 How they built', 'B'], ['❤️ How they felt', 'C'], ['🤔 Is it true', 'D']],
            2: [['🧠 Why it works', 'A'], ['🔧 How to improve', 'B'], ['🌍 Who it helps', 'C'], ['❓ What they assumed', 'D']],
            3: [['🧩 Trace the logic', 'A'], ['⚡ How to apply', 'B'], ['🌍 Think about impact', 'C'], ['💭 Find the flaws', 'D']],
            4: [['📚 Clarify the concepts', 'A'], ['💡 Suggest better models', 'B'], ['🌍 Real world consequences', 'C'], ['⚔️ Challenge the flaws', 'D']],
            5: [['🧠 Deep concepts', 'A'], ['🔧 Practical tools', 'B'], ['❤️ Emotional connection', 'C'], ['💭 Critical thinking', 'D']],
            6: [['😑 Shallow arguments', 'A'], ['🐌 Inefficient systems', 'B'], ['💔 People not caring', 'C'], ['🤦 Over simplified stuff', 'D']]
        ]
        
        questions.each { qData ->
            def question = new GameQuestion(
                questionId: "CURIOSITY_COMPASS_Q${qData.number}",
                gameType: 'CURIOSITY_COMPASS',
                questionNumber: qData.number,
                questionText: qData.text,
                questionType: 'MULTIPLE_CHOICE',
                scoringDimension: 'CURIOSITY_TYPE'
            ).save(flush: true)
            
            optionsData[qData.number].eachWithIndex { opt, index ->
                def option = new GameOption(
                    question: question,
                    optionText: opt[0],
                    optionValue: opt[1],
                    displayOrder: index + 1
                ).save(flush: true)
                
                // Map values to persona types
                def personaMap = ['A': 'THEORIST', 'B': 'BUILDER', 'C': 'EMPATH', 'D': 'CHALLENGER']
                createPersonaMapping(option, personaMap[opt[1]])
            }
        }
    }
    
    void migrateFocusStamina() {
        println "Migrating Focus Stamina..."
        
        def questions = [
            [number: 1, text: 'Your mind keeps getting distracted', dimension: 'ATTENTION_SUSTAIN', type: 'INTERACTIVE', timeLimit: 180],
            [number: 2, text: 'This puzzle feels impossible right now', dimension: 'STRESS_RESPONSE', type: 'INTERACTIVE']
        ]
        
        def optionsData = [
            2: [['😵 Give up now', 'GIVE_UP'], ['💡 Show me hint', 'SHOW_HINT'], ['🔥 Submit my answer', 'SUBMIT']]
        ]
        
        questions.each { qData ->
            def question = new GameQuestion(
                questionId: "FOCUS_STAMINA_${qData.dimension}",
                gameType: 'FOCUS_STAMINA',
                questionNumber: qData.number,
                questionText: qData.text,
                questionType: qData.type,
                scoringDimension: qData.dimension,
                timeLimit: qData.timeLimit
            ).save(flush: true)
            
            if (optionsData[qData.number]) {
                optionsData[qData.number].eachWithIndex { opt, index ->
                    def option = new GameOption(
                        question: question,
                        optionText: opt[0],
                        optionValue: opt[1],
                        displayOrder: index + 1
                    ).save(flush: true)
                    
                    // Create grit level mappings
                    if (opt[1] == 'GIVE_UP') createPersonaMapping(option, 'LOW_GRIT')
                    else if (opt[1] == 'SHOW_HINT') createPersonaMapping(option, 'MEDIUM_GRIT')
                    else if (opt[1] == 'SUBMIT') createPersonaMapping(option, 'HIGH_GRIT')
                }
            }
        }
    }
    
    void migrateGuessworkQuotient() {
        println "Migrating Guesswork Quotient..."
        
        def questions = [
            [number: 1, text: 'Which of these elements has the highest atomic number'],
            [number: 2, text: 'What is the capital city of Australia'],
            [number: 3, text: 'Which planet has the most moons orbiting it'],
            [number: 4, text: 'Which author wrote the famous book 1984'],
            [number: 5, text: 'What is the speed of light in kilometers per second'],
            [number: 6, text: 'What was the first programming language ever created'],
            [number: 7, text: 'What is the largest ocean on planet Earth'],
            [number: 8, text: 'How many bones are in an adult human body'],
            [number: 9, text: 'What is the chemical symbol for gold element'],
            [number: 10, text: 'Which country has the longest coastline in the world']
        ]
        
        def optionsData = [
            1: [['🥇 Gold', 'GOLD', false], ['🥈 Silver', 'SILVER', false], ['⚪ Platinum', 'PLATINUM', true], ['💧 Mercury', 'MERCURY', false]],
            2: [['🌊 Sydney', 'SYDNEY', false], ['🏙️ Melbourne', 'MELBOURNE', false], ['🏛️ Canberra', 'CANBERRA', true], ['🌴 Brisbane', 'BRISBANE', false]],
            3: [['🪐 Jupiter', 'JUPITER', false], ['💍 Saturn', 'SATURN', true], ['🔵 Uranus', 'URANUS', false], ['🌀 Neptune', 'NEPTUNE', false]],
            4: [['📚 Huxley', 'HUXLEY', false], ['📖 Orwell', 'ORWELL', true], ['📕 Bradbury', 'BRADBURY', false], ['📗 Wells', 'WELLS', false]],
            5: [['⚡ 299,792', '299792', true], ['💫 300,000', '300000', false], ['✨ 299,000', '299000', false], ['🌟 298,792', '298792', false]],
            6: [['💻 C', 'C', false], ['🔢 FORTRAN', 'FORTRAN', true], ['📊 BASIC', 'BASIC', false], ['🖥️ Pascal', 'PASCAL', false]],
            7: [['🌊 Atlantic', 'ATLANTIC', false], ['🏖️ Indian', 'INDIAN', false], ['🌏 Pacific', 'PACIFIC', true], ['❄️ Arctic', 'ARCTIC', false]],
            8: [['196', '196', false], ['206', '206', true], ['216', '216', false], ['226', '226', false]],
            9: [['Go', 'GO', false], ['Gd', 'GD', false], ['⚡ Au', 'AU', true], ['Ag', 'AG', false]],
            10: [['🇷🇺 Russia', 'RUSSIA', false], ['🇨🇦 Canada', 'CANADA', true], ['🇺🇸 USA', 'USA', false], ['🇮🇩 Indonesia', 'INDONESIA', false]]
        ]
        
        questions.each { qData ->
            def question = new GameQuestion(
                questionId: "GUESSWORK_Q${qData.number}",
                gameType: 'GUESSWORK_QUOTIENT',
                questionNumber: qData.number,
                questionText: qData.text,
                questionType: 'BETTING',
                scoringDimension: 'RISK_ASSESSMENT'
            ).save(flush: true)
            
            optionsData[qData.number].eachWithIndex { opt, index ->
                def option = new GameOption(
                    question: question,
                    optionText: opt[0],
                    optionValue: opt[1],
                    displayOrder: index + 1,
                    isCorrect: opt[2]
                ).save(flush: true)
                
                // Risk assessment mappings
                createPersonaMapping(option, 'RISK_PROFILE')
            }
        }
    }
    
    void migrateModalityMap() {
        println "Migrating Modality Map..."
        
        def questions = [
            [number: 1, text: 'You don\'t understand this topic clearly'],
            [number: 2, text: 'Your most memorable class felt like this'],
            [number: 3, text: 'When you revise material it works best'],
            [number: 4, text: 'You take notes during class like this'],
            [number: 5, text: 'Most annoying thing when you are learning'],
            [number: 6, text: 'You missed class and need to catch up']
        ]
        
        def optionsData = [
            1: [['👁️ Need to see diagrams', 'A'], ['👂 Need to hear lecture', 'B'], ['✋ Need to do practice', 'C'], ['🧠 Need an analogy', 'D']],
            2: [['👁️ Charts on board', 'A'], ['👂 Clear speaker talking', 'B'], ['✋ Labs and demos', 'C'], ['🧠 Abstract deep talk', 'D']],
            3: [['👁️ Draw mind maps', 'A'], ['👂 Recite out loud', 'B'], ['✋ Solve problems again', 'C'], ['🧠 Explain to yourself', 'D']],
            4: [['👁️ Sketches and bullets', 'A'], ['👂 Audio summary recording', 'B'], ['✋ Scribble while doing', 'C'], ['🧠 Structure the meaning', 'D']],
            5: [['👁️ No visuals shown', 'A'], ['👂 Unclear speaker voice', 'B'], ['✋ Just reading only', 'C'], ['🧠 Rote memory boring', 'D']],
            6: [['👁️ Get the slides', 'A'], ['👂 Hear explanation friend', 'B'], ['✋ Practice the questions', 'C'], ['🧠 Read the summaries', 'D']]
        ]
        
        questions.each { qData ->
            def question = new GameQuestion(
                questionId: "MODALITY_MAP_Q${qData.number}",
                gameType: 'MODALITY_MAP',
                questionNumber: qData.number,
                questionText: qData.text,
                questionType: 'MULTIPLE_CHOICE',
                scoringDimension: 'LEARNING_MODALITY'
            ).save(flush: true)
            
            optionsData[qData.number].eachWithIndex { opt, index ->
                def option = new GameOption(
                    question: question,
                    optionText: opt[0],
                    optionValue: opt[1],
                    displayOrder: index + 1
                ).save(flush: true)
                
                // Map values to learning modalities
                def modalityMap = ['A': 'VISUAL', 'B': 'AUDITORY', 'C': 'KINESTHETIC', 'D': 'CONCEPTUAL']
                createPersonaMapping(option, modalityMap[opt[1]])
            }
        }
    }
    
    void migratePatternSnapshot() {
        println "Migrating Pattern Snapshot..."
        
        def questions = [
            [number: 1, text: 'You almost see the pattern what comes next', dimension: 'VISUAL'],
            [number: 2, text: 'Fold paper twice and cut corner how many holes', dimension: 'VISUAL'],
            [number: 3, text: 'Book is to Read as Knife is to', dimension: 'VERBAL'],
            [number: 4, text: 'Hot is to Cold as Day is to', dimension: 'VERBAL'],
            [number: 5, text: 'You see a pattern forming what is next', dimension: 'NUMERIC'],
            [number: 6, text: 'Five machines make five widgets in five minutes', dimension: 'NUMERIC']
        ]
        
        def optionsData = [
            1: [['⭕ Circle', 'CIRCLE', false], ['🔲 Square', 'SQUARE', false], ['🔺 Triangle', 'TRIANGLE', true], ['⬟ Pentagon', 'PENTAGON', false]],
            2: [['1 hole', '1', false], ['2 holes', '2', false], ['4 holes', '4', true], ['8 holes', '8', false]],
            3: [['⚡ Sharp', 'SHARP', false], ['✂️ Cut', 'CUT', true], ['🔩 Metal', 'METAL', false], ['🥄 Spoon', 'SPOON', false]],
            4: [['☀️ Sun', 'SUN', false], ['🌙 Night', 'NIGHT', true], ['🌕 Moon', 'MOON', false], ['🌑 Dark', 'DARK', false]],
            5: [['18', '18', false], ['24', '24', false], ['32', '32', true], ['36', '36', false]],
            6: [['⚡ 5 minutes', '5', true], ['20 minutes', '20', false], ['100 minutes', '100', false], ['500 minutes', '500', false]]
        ]
        
        questions.each { qData ->
            def question = new GameQuestion(
                questionId: "PATTERN_SNAPSHOT_Q${qData.number}",
                gameType: 'PATTERN_SNAPSHOT',
                questionNumber: qData.number,
                questionText: qData.text,
                questionType: 'MULTIPLE_CHOICE',
                scoringDimension: qData.dimension
            ).save(flush: true)
            
            optionsData[qData.number].eachWithIndex { opt, index ->
                def option = new GameOption(
                    question: question,
                    optionText: opt[0],
                    optionValue: opt[1],
                    displayOrder: index + 1,
                    isCorrect: opt[2]
                ).save(flush: true)
                
                createPersonaMapping(option, qData.dimension)
            }
        }
    }
    
    void migrateSpiritAnimal() {
        println "Migrating Spirit Animal..."
        
        def questions = [
            [number: 1, text: 'You see a new tough chapter you need to learn', dimension: 'PROCESS_VS_INTUITION'],
            [number: 2, text: 'You are 70% done and feel tired', dimension: 'ACCURACY_VS_SPEED'],
            [number: 3, text: 'You got it wrong and trying to figure out why', dimension: 'PROCESS_VS_INTUITION'],
            [number: 4, text: 'Which teacher style works best for you', dimension: 'PROCESS_VS_INTUITION'],
            [number: 5, text: 'During exam you need complete silence to focus', dimension: 'ACCURACY_VS_SPEED'],
            [number: 6, text: 'Your class notes usually look like this', dimension: 'PROCESS_VS_INTUITION'],
            [number: 7, text: 'You are not sure but must answer now', dimension: 'ACCURACY_VS_SPEED'],
            [number: 8, text: 'Night before exam you are still studying', dimension: 'PROCESS_VS_INTUITION'],
            [number: 9, text: 'Memorizing formulas and facts feels like this', dimension: 'PROCESS_VS_INTUITION'],
            [number: 10, text: 'Your biggest fear during exam is this', dimension: 'ACCURACY_VS_SPEED'],
            [number: 11, text: 'You finished early and have time left', dimension: 'ACCURACY_VS_SPEED'],
            [number: 12, text: 'Group study session is happening right now', dimension: 'PROCESS_VS_INTUITION']
        ]
        
        def optionsData = [
            1: [['📖 Read theory first', 'A'], ['⚡ Jump to practice', 'B']],
            2: [['😵‍💫 Feel drained', 'A'], ['🏃 Rush to finish', 'B']],
            3: [['🧠 Concept not clear', 'A'], ['😅 Silly mistake only', 'B']],
            4: [['📚 Deep explanations', 'A'], ['⚡ Quick tricks tips', 'B']],
            5: [['🔇 Yes need it', 'A'], ['😐 Don\'t care much', 'B']],
            6: [['✨ Very organized', 'A'], ['📝 Messy scribbles', 'B']],
            7: [['❌ Leave it blank', 'A'], ['🎯 Trust gut feeling', 'B']],
            8: [['📚 Study weak topics', 'A'], ['😴 Sleep and trust', 'B']],
            9: [['✅ Important part', 'A'], ['😑 Boring just skip', 'B']],
            10: [['😰 Forget the steps', 'A'], ['⏰ Run out time', 'B']],
            11: [['🔍 Check all answers', 'A'], ['✅ Done just relax', 'B']],
            12: [['📋 Follow the syllabus', 'A'], ['💭 Ask what if questions', 'B']]
        ]
        
        questions.each { qData ->
            def question = new GameQuestion(
                questionId: "SPIRIT_ANIMAL_Q${qData.number}",
                gameType: 'SPIRIT_ANIMAL',
                questionNumber: qData.number,
                questionText: qData.text,
                questionType: 'MULTIPLE_CHOICE',
                scoringDimension: qData.dimension
            ).save(flush: true)
            
            optionsData[qData.number].eachWithIndex { opt, index ->
                def option = new GameOption(
                    question: question,
                    optionText: opt[0],
                    optionValue: opt[1],
                    displayOrder: index + 1
                ).save(flush: true)
                
                // Map to process/intuition and accuracy/speed traits
                if (qData.dimension == 'PROCESS_VS_INTUITION') {
                    createPersonaMapping(option, opt[1] == 'A' ? 'PROCESS' : 'INTUITION')
                } else {
                    createPersonaMapping(option, opt[1] == 'A' ? 'ACCURACY' : 'SPEED')
                }
            }
        }
    }
    
    void migrateWorkMode() {
        println "Migrating Work Mode..."
        
        def questions = [
            [number: 1, text: 'You get a group assignment suddenly', dimension: 'SOLO_VS_TEAM'],
            [number: 2, text: 'When you start tasks you prefer to', dimension: 'STRUCTURED_VS_FLEXIBLE'],
            [number: 3, text: 'Your best assignment would feel like this', dimension: 'SOLO_VS_TEAM'],
            [number: 4, text: 'You are stuck on a hard problem', dimension: 'SOLO_VS_TEAM'],
            [number: 5, text: 'Your study session works best when it is', dimension: 'STRUCTURED_VS_FLEXIBLE']
        ]
        
        def optionsData = [
            1: [['👤 Work alone better', 'A'], ['🤝 Work with team', 'B']],
            2: [['📋 Make fixed plan', 'A'], ['🌊 Go with flow', 'B']],
            3: [['👤 Individual work only', 'A'], ['🤝 Group brainstorm together', 'B']],
            4: [['🤐 Keep trying quietly', 'A'], ['💬 Talk it out', 'B']],
            5: [['⏰ Timed and planned', 'A'], ['🌊 Spontaneous and flowing', 'B']]
        ]
        
        questions.each { qData ->
            def question = new GameQuestion(
                questionId: "WORK_MODE_Q${qData.number}",
                gameType: 'WORK_MODE',
                questionNumber: qData.number,
                questionText: qData.text,
                questionType: 'MULTIPLE_CHOICE',
                scoringDimension: qData.dimension
            ).save(flush: true)
            
            optionsData[qData.number].eachWithIndex { opt, index ->
                def option = new GameOption(
                    question: question,
                    optionText: opt[0],
                    optionValue: opt[1],
                    displayOrder: index + 1
                ).save(flush: true)
                
                // Map to work style traits
                if (qData.dimension == 'SOLO_VS_TEAM') {
                    createPersonaMapping(option, opt[1] == 'A' ? 'SOLO' : 'TEAM')
                } else {
                    createPersonaMapping(option, opt[1] == 'A' ? 'STRUCTURED' : 'FLEXIBLE')
                }
            }
        }
    }
    
    void migratePersonality() {
        println "Migrating Personality..."
        
        def questions = [
            'I prefer structured routines over spontaneous activities.',
            'I feel energized when working in a team rather than alone.',
            'I often look for patterns and connections others may miss.',
            'I stay focused and calm under pressure.',
            'I enjoy exploring new ideas even if they are unconventional.'
        ]
        
        questions.eachWithIndex { qText, index ->
            def number = index + 1
            def question = new GameQuestion(
                questionId: "PERSONALITY_Q${number}",
                gameType: 'PERSONALITY',
                questionNumber: number,
                questionText: qText,
                questionType: 'LIKERT',
                scoringDimension: 'PERSONALITY_TRAIT'
            ).save(flush: true)
            
            // Likert scale options
            def likertOptions = [
                [text: 'Strongly disagree', value: '-3'],
                [text: 'Disagree', value: '-2'],
                [text: 'Somewhat disagree', value: '-1'],
                [text: 'Somewhat agree', value: '1'],
                [text: 'Agree', value: '2'],
                [text: 'Strongly agree', value: '3']
            ]
            
            likertOptions.eachWithIndex { opt, idx ->
                def option = new GameOption(
                    question: question,
                    optionText: opt.text,
                    optionValue: opt.value,
                    displayOrder: idx + 1
                ).save(flush: true)
                
                createPersonaMapping(option, 'PERSONALITY_SPECTRUM')
            }
        }
    }
    
    void createPersonaMapping(GameOption option, String personaType) {
        def mapping = new OptionPersonaMapping(
            gameOption: option,
            personaType: personaType,
            traitCategory: 'PRIMARY',
            weight: 1
        ).save(flush: true)
    }
}
