//
//  QuizManager.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/18/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit


class QuizManager {
    
    // Properties:

    let quiz: [Question]
    var allQuestionsEachRound = [Question]()
    var questionsPerRound = 4
    var correctQuestions = 0
    var questionsAsked = 0
    var options = [String]()
    var indexOfCurrentQuestion = 0
    let soundManager = SoundManager()
    var buttons = [UIButton]()
    var nextQuestion: String = "next question"
    
    init(quiz: [Question]) {
        self.quiz = quiz
        
    }
    
    // Functions:
    
    // Make an Array for all option buttons.
    func createOptionButtonsArray(button1: UIButton, button2: UIButton, button3: UIButton, button4: UIButton) {
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        buttons.append(button4)
    }
    
    // Create new non-repeat and random 'Question' objects into the 'allQuestionsEachRound' empty array.
    func questionsGenerator() {
        let questionIndexProvider = GKShuffledDistribution.init(lowestValue: 0, highestValue: quiz.count - 1)
        for _ in 0..<questionsPerRound {
            allQuestionsEachRound.append(quiz[questionIndexProvider.nextInt()])
        }
    }
    
    // Reset all properties in QuizManager.
    // Get ready for next Round of game.
    func loadNewGameData() {
        correctQuestions = 0
        questionsAsked = 0
        allQuestionsEachRound = [Question]()
        indexOfCurrentQuestion = 0
        questionsGenerator()
    }
    
    // Give value to nextQuestion and options.
    // Get ready to be set on questionField and optionButtons' title.
    // Options is shuffled so that will appear on the buttons differently each time.
    func createNextQuestion() {
        let nextQuestionDict = allQuestionsEachRound[indexOfCurrentQuestion]
        nextQuestion = nextQuestionDict.question
        options = [String]()
        let optionIndexesGenerator = GKShuffledDistribution.init(lowestValue: 0, highestValue: nextQuestionDict.options.count - 1)
        for _ in 0..<nextQuestionDict.options.count {
            options.append(nextQuestionDict.options[(optionIndexesGenerator.nextInt())])
        }
    }
    
    // This function is to be used in 'chooseAnAnswer()' in view controller.
    // It checks user's choice if it is correct answer, and it shows different result on 'showResultField'.
    // Based on if the user's choice is correct or not, the button he/she choose will turn to different colors.
    func checkAnswer(sender: UIButton, showResultField: UILabel!) {
        
        let selectedQuestionDict = allQuestionsEachRound[indexOfCurrentQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        if sender.currentTitle == correctAnswer {
            soundManager.playCorrctAnswerSound()
            let correctAnswerColor = UIColor(red: 124/255, green: 201/255, blue: 155/255, alpha: 1.0)
            showResultField.textColor = correctAnswerColor
            correctQuestions += 1
            showResultField.isHidden = false
            showResultField.text = "Good Job, you got it!"
            sender.backgroundColor = correctAnswerColor
        } else {
            soundManager.playWrongAnswerSound()
            let wrongAnswerColor = UIColor(red: 255/255, green: 41/255, blue: 90/255, alpha: 1.0)
            showResultField.textColor = wrongAnswerColor
            showResultField.isHidden = false
            showResultField.text = "Not that one!!"
            sender.backgroundColor = wrongAnswerColor
        }
        questionsAsked += 1
        indexOfCurrentQuestion += 1
    }
        
}
    
































