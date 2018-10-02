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
    

    // Change the layout, only three opiton will displayed, distance between each option will increase.
    // It makes the layout look more stretched and better when only three options in the current question.
    // 3-option layout
    func changeToThreeOptionLayOut() {
        option4Button.isHidden = true
        constraintBetweenButtonOneAndTwo.constant = 72
        constraintBetweenButtonTwoAndThree.constant = 72
        self.view.layoutIfNeeded()
    }
    
    // This function will return the layout to original 4-option layout.
    // 4-option layout
    func returnToOriginalLayout() {
        option4Button.isHidden = false
        
        constraintBetweenButtonOneAndTwo.constant = 42
        constraintBetweenButtonTwoAndThree.constant = 42
        self.view.layoutIfNeeded()
    }
    
    // Since I do not know any advanced stuff right now, I try this way to change the check mark position.
    // This function does some calculation and move check mark image shows on the right inside of the correct answer option button.
    // It simply just add and substract the checkMarkTopConstraint and checkMarkBottomConstraint value to make it equal with the correct answer button.
    func changeCheckMarkPosition() {
        
        for (index, option) in quizManager.options.enumerated() {
            if option == quizManager.allQuestionsEachRound[quizManager.indexOfCurrentQuestion].correctAnswer {
                checkMarkTopConstraint.constant += ((CGFloat(buttonHight) + constraintBetweenButtonOneAndTwo.constant) * CGFloat(index))
                checkMarkBottomConstraint.constant -= ((CGFloat(buttonHight) + constraintBetweenButtonOneAndTwo.constant) * CGFloat(index))
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    // changeCheckMarkPositon does the calculation based on the original position of checkMark.
    // As a result, this function runs every time a new question displayed.
    func returnCheckMarkBackToPosition() {
        checkMarkTopConstraint.constant = 24
        checkMarkBottomConstraint.constant = 318
        self.view.layoutIfNeeded()
    }
    
}
