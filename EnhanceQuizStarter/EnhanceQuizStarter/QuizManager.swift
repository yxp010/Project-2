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
    
    
    let quiz: [Question]
    var questionsArray = [Question]()
    var questionsPerRound = 4
    var correctQuestions = 0
    var questionsAsked = 0
    var options = [String]()
    var indexOfCurrentQuestion = 0
    let soundManager = SoundManager()
    var secondsOnTimer = 15
    var buttons = [UIButton]()
    var nextQuestion: String = "next question"
    init(quiz: [Question]) {
        self.quiz = quiz
        
    }
    
    // Make an Array for all option buttons array.
    func createOptionButtonsArray(button1: UIButton, button2: UIButton, button3: UIButton, button4: UIButton) {
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        buttons.append(button4)
    }
    
    func questionsGenerator() {
        questionsArray = [Question]()
        let questionIndexProvider = GKShuffledDistribution.init(lowestValue: 0, highestValue: quiz.count - 1)
        for _ in 0..<questionsPerRound {
            questionsArray.append(quiz[questionIndexProvider.nextInt()])
        }
    }
    func loadNewGameData() {
        correctQuestions = 0
        questionsAsked = 0
        questionsArray = [Question]()
        indexOfCurrentQuestion = 0
        questionsGenerator()
    }
    func createNextQuestion() {
        let nextQuestionDict = questionsArray[indexOfCurrentQuestion]
        nextQuestion = nextQuestionDict.question
        options = [String]()
        let optionIndexesGenerator = GKShuffledDistribution.init(lowestValue: 0, highestValue: nextQuestionDict.options.count - 1)
        for _ in 0..<nextQuestionDict.options.count {
            options.append(nextQuestionDict.options[(optionIndexesGenerator.nextInt())])
        }
    }
    
    func checkAnswer(sender: UIButton, showCorrectAnswerField: UILabel!, timer: Timer!, playAgainButton: UIButton) {
        let selectedQuestionDict = questionsArray[indexOfCurrentQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        if sender.currentTitle == correctAnswer {
            sender.backgroundColor = UIColor.black
            soundManager.playCorrctAnswerSound()
            correctQuestions += 1
            showCorrectAnswerField.isHidden = false
            showCorrectAnswerField.text = "Good Job, you got it!"
            
        } else {
            sender.backgroundColor = UIColor.cyan
            soundManager.playWrongAnswerSound()
            showCorrectAnswerField.isHidden = false
            showCorrectAnswerField.text = "Not that one!!"
        }
        
        for button in buttons {
            button.isEnabled = false
        }
        
        timer.invalidate()
        playAgainButton.isHidden = false
        questionsAsked += 1
        indexOfCurrentQuestion += 1
    }
        
}
    
































