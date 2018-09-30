//
//  RoundTransitionHelperFunc.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/30/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    func nextRound() {
        secondsOnTimer = 15
        if quizManager.questionsAsked == quizManager.questionsPerRound {
            // Game is over
            
            quizManager.displayScore(timerField: timer, playAgainButton: playAgainButton, questionField: questionField)
        } else {
            // Continue game
            for button in quizManager.buttons {
                button.isEnabled = true
            }
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
}
