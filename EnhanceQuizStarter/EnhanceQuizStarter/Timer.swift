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
            checkMark.isHidden = false
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
            showResultField.isHidden = false
            showResultField.text = "Time Out!"
        } else {
            timer.text = String(secondsOnTimer)
        }
    }
}




