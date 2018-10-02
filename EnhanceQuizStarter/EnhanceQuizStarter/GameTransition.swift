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
    
    // This function reset all information in quizManager by run 'quizManager.loadNewGameData()' and runs 'nextQuestion()'.
    func nextRound() {
        quizManager.loadNewGameData()
        nextQuestion()
    }
    
    // This function runs 'quizManager.createNextQuestion' to create a question and options of the question that all need to be show on screen (informations that need to be used in 'displayQuestion()').
    // Use 'checkNumberOfOptions()' to layout the question.
    // Finally display the next question by running 'displayQuestion()'
    func nextQuestion() {
        quizManager.createNextQuestion()
        questionField.text = quizManager.nextQuestion
        secondsOnTimer = initialTimePerQuestion
        checkNumberOfOptionsAndSetOptionTitle()
        displayQuestion()
    }
    
    // Function used in 'nextQuestion()'.
    // Check the layout should be 3-option layout or 4-option layout.
    func checkNumberOfOptionsAndSetOptionTitle() {
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
    }
}
