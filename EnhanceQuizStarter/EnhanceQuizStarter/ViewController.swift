//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox
import WatchKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    
    let initialTimePerQuestion = 15
    var secondsOnTimer = 15
    let soundManager = SoundManager()
    var gameTimer: Timer!
    let quizManager = QuizManager(quiz: allQuestions)
    let nextQuestionButtonTitle = "Next Question"
    let playAgainButtonTitle = "Play Again"
    var optionsArray = [String]()
    var currentRoundQuestion: Question = question1
    let buttonHight = 50

    
    // MARK: - Outlets
    
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var showCorrectAnswerField: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!

    @IBOutlet weak var checkMarkTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkMarkBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var constraintBetweenButtonOneAndTwo: NSLayoutConstraint!
    @IBOutlet weak var constraintBetweenButtonTwoAndThree: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizManager.createOptionButtonsArray(button1: option1Button, button2: option2Button, button3: option3Button, button4: option4Button)
        changeButtonsShape()
        quizManager.loadNewGameData()
        soundManager.playGameStartsound()
        nextQuestion()
        

    }
    
    func changeButtonsShape() {
        for button in quizManager.buttons {
            button.layer.cornerRadius = 11
        }
        playAgainButton.layer.cornerRadius = 11
    }
    
    //Display function for the game each round.
    func displayQuestion() {
        //Select and display current round question.
        
        //
        checkMark.isHidden = true
        timer.text = String(secondsOnTimer)
        playAgainButton.isHidden = true
        timer.isHidden = false
        showCorrectAnswerField.isHidden = true
        
        //Start the Timer.
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        
        for button in quizManager.buttons {
            button.isEnabled = true
        }
        //Create a random options Index to get the options from the currentRoundQuestion.option for each option button. It makes that the options showing on the buttons are placed in different positions each time.
        
        
        let optionBackgroundColor = UIColor(displayP3Red: 171/255.0, green: 89/255.0, blue: 90/255.0, alpha: 1.0)
        
        for button in quizManager.buttons {
            button.backgroundColor = optionBackgroundColor
        }
        if quizManager.questionsAsked == quizManager.questionsPerRound - 1 {
            playAgainButton.setTitle(playAgainButtonTitle, for: UIControlState.normal)
        } else {
            playAgainButton.setTitle(nextQuestionButtonTitle, for: UIControlState.normal)
        }
    }
    func displayScore() {
        // Hide the answer buttons
        
        // Display play again button
        gameTimer.invalidate()
        timer.isHidden = true
        
        
        questionField.text = "Way to go!\nYou got \(quizManager.correctQuestions) out of \(quizManager.questionsPerRound) correct!"

    }
    
    // MARK: - Actions
    
    @IBAction func chooseAnAnswer(_ sender: UIButton) {
        secondsOnTimer = initialTimePerQuestion
        changeCheckMarkPosition()
        checkMark.isHidden = false
        quizManager.checkAnswer(sender: sender, showCorrectAnswerField: showCorrectAnswerField, timer: gameTimer, playAgainButton: playAgainButton)
        if quizManager.questionsAsked == quizManager.questionsPerRound {
            displayScore()
        }
    }
    
    @IBAction func playAgain() {
        if playAgainButton.currentTitle == nextQuestionButtonTitle {
            
            nextQuestion()
        } else {
            
            nextRound()
        }
    }

}
