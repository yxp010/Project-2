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
    
    var selectedIndexes = [Int]()
    let quiz: Quiz
    var quizPerRound = [String]()
    var allIndexes = [Int]()
    var questionsAsked = 0
    init(quiz: Quiz) {
        self.quiz = quiz
        allIndexes = Array(0..<quiz.questions.count)
        
    }
    func questionProvider() {
        questionsAsked += 1
        
    }
    func quizProvider() -> Question {
        return quiz.questions[selectedIndexes.remove(at: 0)]
    }
    func checkCorrectAnswer(choice: UIButton) -> Bool {
        
        return true
    }
}































