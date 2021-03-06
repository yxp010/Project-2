//
//  Questions.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/17/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

// A Struct that builds questions.
struct Question {
    
    // Properties:
    
    let question: String
    let options: [String]
    let correctAnswer: String
    
    init(question: String, options: [String], correctAnswer: String) {
        self.question = question
        self.options = options
        self.correctAnswer = correctAnswer
    }

}

// All Question objects:

let question1 = Question(question: "When the first qualifying game for 2018 World Cup took place?", options: ["10 March 2015", "12 March 2015", "14 April 2015", "19 May 2015"], correctAnswer: "12 March 2015")
let question2 = Question(question: "How many teams has been qualified for Fifa World Cup 2018?", options: ["22", "32", "42", "40"], correctAnswer: "32")
let question3 = Question(question: "There are how many host cities of Fifa World Cup 2018?", options: ["10", "11", "12", "13"], correctAnswer: "11")
let question4 = Question(question: "There are how many groups in Fifa World Cup 2018 championships?", options: ["16", "8", "10", "12"], correctAnswer: "8")
let question5 = Question(question: "There are how many teams in a group in FIFA World Cup 2018 championships?", options: ["6", "8", "4", "10"], correctAnswer: "4")
let question6 = Question(question: "How many times the FIFA World Cup held so far till 2018?", options: ["18", "19", "20", "21"], correctAnswer: "19")
let question7 = Question(question: "What is the venue of Fifa World cup 2018 final championship?", options: ["Luzhniki Stadium", "Krestovsky Stadium", "Kaliningrad Stadium", "Central Stadium"], correctAnswer: "Luzhniki Stadium")
let question8 = Question(question: "What are the two countries first ever appearing in FIFA World Cup 2018?", options: ["Morocco and Peru", "Panama and Iceland", "Serbia and Poland", "Senegal and Tunisia"], correctAnswer: "Panama and Iceland")
let question9 = Question(question: "What is the host team of FIFA World Cup 2018?", options: ["Spain", "Germany", "Russia", "Portugal"], correctAnswer: "Russia")
let question10 = Question(question: "Which two teams will play the opening match in 2018 FIFA World Cup?", options: ["Poland and Russia", "Russia and Saudi Arabia", "Russia and Egypt", "Russia and Uruguay"], correctAnswer: "Russia and Saudi Arabia")
let question11 = Question(question: "In which city the Luzhniki Stadium is located?", options: ["Leningrad", "Saint Petersberg", "Moscow", "Volgograd"], correctAnswer: "Moscow")
let question12 = Question(question: "Which of the following countries did not take part in World Cup 2006?", options: ["Ghana", "Ireland", "Australia"], correctAnswer: "Ireland")
let question13 = Question(question: "When did Football World Cup 2018 begin?", options: ["8 February 2018", "14 June 2018", "15 March 2018"], correctAnswer: "14 June 2018")
let question14 = Question(question: "Who shot the first goal in Football World Cup 2018?", options: ["Yury Gazinsky", "Aleksandr Golovin", "Artem Dzyuba"], correctAnswer: "Yury Gazinsky")
let question15 = Question(question: "What was the result of Russia versus Saudi Arabia match in Football World Cup 2018?", options: ["Saudi Arabia won 2-1", "2-2 Draw", "Russia won 5-0"], correctAnswer: "Russia won 5-0")
let question16 = Question(question: "Who scored three goals for Portugal against Spain in Football World Cup 2018?", options: ["Cristiano Ronaldo", "Ricardo Quaresma", "Bernardo Silva"], correctAnswer: "Cristiano Ronaldo")

// An array for all Question objects.
let worldCupQuestions = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10, question11,question12, question13, question14, question15, question16]

