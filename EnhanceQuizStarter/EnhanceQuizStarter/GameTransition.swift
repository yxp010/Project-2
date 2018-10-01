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
        
        quizManager.loadNewGameData()
        secondsOnTimer = initialTimePerQuestion
            // Game is over
        nextQuestion()
        
    }
    
    func nextQuestion() {
        quizManager.createNextQuestion()
        questionField.text = quizManager.nextQuestion
        returnCheckMarkBackToPosition()
        
        secondsOnTimer = initialTimePerQuestion
        if quizManager.options.count == 3 {
            
            changeToThreeOptionLayOut()
            var buttonIndex = 0
            for button in quizManager.buttons {
                if buttonIndex == 3 {
                    break
                }
                button.setTitle(quizManager.options[buttonIndex], for: UIControlState.normal)
                buttonIndex += 1
            }
        } else {
            returnToOriginalLayout()
            
            for (index, button) in quizManager.buttons.enumerated() {
                button.setTitle(quizManager.options[index], for: UIControlState.normal)
            }
        }
        
        displayQuestion()
        
        
    }
    
}
