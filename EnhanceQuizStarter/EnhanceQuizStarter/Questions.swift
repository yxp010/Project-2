//
//  Questions.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/17/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

struct Question {
    let question: String
    let options: [String]
    let correctAnswer: String
    
    init(question: String, options: [String], correctAnswer: String) {
        self.question = question
        self.options = options
        self.correctAnswer = correctAnswer
        
    }

}

let question1 = Question(question: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington", "Woodrow Wilson", "Andrew Jackson", "Franklin D. Roosevelt"], correctAnswer: "Franklin D. Roosevelt")
let question2 = Question(question: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], correctAnswer: "Vietnam")
let question3 = Question(question: "In what year was the United Nations founded?", options: ["1918", "1919", "1945", "1954"], correctAnswer: "1945")
let question4 = Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris", "Washington D.C.", "New York City", "Boston"], correctAnswer: "Boston")





