//
//  ThreeQuestionLayout.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/30/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    func changeToThreeOptionLayOut() {
        option4Button.isHidden = true
        constraintBetweenButtonOneAndTwo.constant = 60
        constraintBetweenButtonTwoAndThree.constant = 60
        self.view.layoutIfNeeded()
    }
    func returnToOriginalLayout() {
        option4Button.isHidden = false
        
        constraintBetweenButtonOneAndTwo.constant = 40
        constraintBetweenButtonTwoAndThree.constant = 40
        self.view.layoutIfNeeded()
        
    }
    func showPlayAgainButton() {
        playAgainButton.isHidden = false
        if quizManager.questionsAsked == quizManager.questionsPerRound {
            
        }
    }
    func changeCheckMarkPosition() {
        
        for (index, option) in quizManager.options.enumerated() {
            if option == quizManager.questionsArray[quizManager.indexOfCurrentQuestion].correctAnswer {
                checkMarkTopConstraint.constant += ((CGFloat(buttonHight) + constraintBetweenButtonOneAndTwo.constant) * CGFloat(index))
                checkMarkBottomConstraint.constant -= ((CGFloat(buttonHight) + constraintBetweenButtonOneAndTwo.constant) * CGFloat(index))
                self.view.layoutIfNeeded()
            }
            
        }
    }
    func returnCheckMarkBackToPosition() {
        checkMarkTopConstraint.constant = 21
        checkMarkBottomConstraint.constant = 310
        self.view.layoutIfNeeded()
    }
    
}
