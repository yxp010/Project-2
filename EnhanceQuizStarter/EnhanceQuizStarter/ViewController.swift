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
    
    // MARK: - Properties:

    
    let initialTimePerQuestion = 15
    var secondsOnTimer = 15
    let soundManager = SoundManager()
    var gameTimer: Timer!
    let quizManager = QuizManager(quiz: allQuestions)
    let nextQuestionButtonTitle = "Next Question"
    let playAgainButtonTitle = "Play Again"
    var optionsArray = [String]()
    let buttonHight = 50
    var checkMarkImage: UIImage?
    
    

    
    // MARK: - Outlets:
    
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var showResultField: UILabel!
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
        checkMark.image = #imageLiteral(resourceName: "action_027-checkmark-done-check-finish-512")
        changeButtonsShape()
        quizManager.loadNewGameData()
        soundManager.playGameStartsound()
        nextQuestion()
    }
    
    // MARK: - Helper Functions
    
    // Function used in viewDidLoad(), change the cornor's of the buttons to round shape.
    func changeButtonsShape() {
        for button in quizManager.buttons {
            button.layer.cornerRadius = 11
        }
        playAgainButton.layer.cornerRadius = 11
    }
    
    // Helper function that load button background and title color.
    func loadButtonColor() {
        for button in quizManager.buttons {
            button.backgroundColor = UIColor(red: 96/255, green: 110/255, blue: 245/255, alpha: 1.0)
        }
        for button in quizManager.buttons {
            button.setTitleColor(UIColor.darkGray, for: UIControlState.disabled)
            button.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
    }

    // Display all stuff on screen each round of question.
    func displayQuestion() {
        returnCheckMarkBackToPosition()
        loadButtonColor()
        
        //Check mark
        checkMark.isHidden = true
        
        //Timer label
        timer.text = String(secondsOnTimer)
        timer.isHidden = false
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        //playAgainButton
        playAgainButton.isHidden = true
        
        //showCorrectAnswer
        showResultField.isHidden = true
        for button in quizManager.buttons {
            button.isEnabled = true
        }
        
        // Use this function change the playAgainButtonTitle before it shows up.
        changePlayAgainButtonTitle()
    }
    
    // Function that display scores after finishing one round of 4 questions.
    func displayScore() {
        gameTimer.invalidate()
        timer.isHidden = true
        questionField.text = "Way to go!\nYou got \(quizManager.correctQuestions) out of \(quizManager.questionsPerRound) correct!"
    }
    
    // Change the text showed on playAgainButton depends on situation.
    func changePlayAgainButtonTitle() {
        if quizManager.questionsAsked == quizManager.questionsPerRound - 1 {
            playAgainButton.setTitle(playAgainButtonTitle, for: UIControlState.normal)
        } else {
            playAgainButton.setTitle(nextQuestionButtonTitle, for: UIControlState.normal)
        }
    }
    
    // MARK: - Actions
    
    // Function that takes one of the optionButton as parameter.
    // After the sender is pressed by user, the user will see the one he/she chose, the correct answer, and a text on top of options.
    @IBAction func chooseAnAnswer(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: UIControlState.disabled)
        secondsOnTimer = initialTimePerQuestion
        changeCheckMarkPosition()
        checkMark.isHidden = false
        quizManager.checkAnswer(sender: sender, showResultField: showResultField)
        if quizManager.questionsAsked == quizManager.questionsPerRound {
            displayScore()
        }
        gameTimer.invalidate()
        playAgainButton.isHidden = false
        for button in quizManager.buttons {
            button.isEnabled = false
            
        }
    }
    
    // The playAgainButton shows up every time after action 'chooseAnAnswer'.
    // It shows a "Next Question" or "Next Round" button, this action function allow users to go to next question or next round if the current round is finished.
    @IBAction func playAgain() {
        for button in quizManager.buttons {
            button.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
        if playAgainButton.currentTitle == nextQuestionButtonTitle {
            nextQuestion()
        } else {
            nextRound()
        }
    }

}
