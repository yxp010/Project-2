//
//  Timer.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/29/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//


import UIKit
extension ViewController {
    @objc
    func countDown() {
        secondsOnTimer -= 1
        timer.text = String(secondsOnTimer)
        if secondsOnTimer <= 0 {
            for button in quizManager.buttons {
                button.isEnabled = false
            }
            soundManager.playWrongAnswerSound()
            gameTimer.invalidate()
            quizManager.questionsAsked += 1
            quizManager.indexOfCurrentQuestion += 1
            playAgainButton.isHidden = false
            if quizManager.questionsAsked == quizManager.questionsPerRound {
                displayScore()
            }
            showCorrectAnswerField.isHidden = false
            showCorrectAnswerField.text = "Time Out!"
        } else {
            timer.text = String(secondsOnTimer)
        }
    }
}




