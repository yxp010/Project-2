//
//  Timer.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/29/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//


import UIKit
extension ViewController {
    
    // Function used in gameTimer: Timer.
    // If 15 seconds run out, showResultField shows "Time out" and play wrongAnswerSound.
    @objc
    func countDown() {
        secondsOnTimer -= 1
        timer.text = String(secondsOnTimer)
        if secondsOnTimer <= 0 {
            display(resultFieldIsHidden: false, checkMarkIsHidden: false, nextQuestionButtonIsHidden: false, optionButtonsEnabled: false)
            soundManager.playWrongAnswerSound()
            gameTimer.invalidate()
            quizManager.questionsAsked += 1
            quizManager.indexOfCurrentQuestion += 1
            if quizManager.questionsAsked == quizManager.questionsPerRound {
                displayScore()
            }
            let wrongAnswerColor = UIColor(red: 255/255, green: 41/255, blue: 90/255, alpha: 1.0)
            showResultField.text = "Time Out!"
            showResultField.tintColor = wrongAnswerColor
        } else {
            timer.text = String(secondsOnTimer)
        }
    }
}




