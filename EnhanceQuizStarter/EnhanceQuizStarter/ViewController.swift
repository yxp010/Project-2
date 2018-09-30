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

    
    
    var secondsOnTimer = 15
    let soundManager = SoundManager()
    var gameTimer: Timer!
    let quizManager = QuizManager(quiz: allQuestions)
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var showCorrectAnswerField: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!

    @IBOutlet weak var constraintBetweenButtonOneAndTwo: NSLayoutConstraint!
    @IBOutlet weak var constraintBetweenButtonTwoAndThree: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizManager.createOptionButtonsArray(button1: option1Button, button2: option2Button, button3: option3Button, button4: option4Button)
        changeButtonsShape()
        quizManager.loadNewGameData()
        soundManager.playGameStartsound()
        displayQuestion()
        

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
        let currentQuestionIndex = quizManager.indexOfCurrentQuestion
        let currentRoundQuestion = quizManager.questionsArray[currentQuestionIndex]
        quizManager.createOptionsArray(question: currentRoundQuestion)
        let optionsArray = quizManager.options
        questionField.text = currentRoundQuestion.question
        
        secondsOnTimer = 15
        timer.text = String(secondsOnTimer)
        playAgainButton.isHidden = true
        timer.isEnabled = true
        showCorrectAnswerField.isHidden = true
        
        //Start the Timer.
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        
        
        //Create a random options Index to get the options from the currentRoundQuestion.option for each option button. It makes that the options showing on the buttons are placed in different positions each time.
        if optionsArray.count == 3 {
            changeToThreeOptionLayOut()
            var buttonIndex = 0
            for button in quizManager.buttons {
                if buttonIndex == 3 {
                    break
                }
                button.setTitle(optionsArray[buttonIndex], for: UIControlState.normal)
                buttonIndex += 1
            }
        } else {
            returnToOriginalLayout()
            for (index, button) in quizManager.buttons.enumerated() {
                button.setTitle(optionsArray[index], for: UIControlState.normal)
            }
        }
        
        let optionBackgroundColor = UIColor(displayP3Red: 171/255.0, green: 89/255.0, blue: 90/255.0, alpha: 1.0)
        
        for button in quizManager.buttons {
            button.backgroundColor = optionBackgroundColor
        }
    }
    
    // MARK: - Actions
    
    @IBAction func chooseAnAnswer(_ sender: UIButton) {
        quizManager.checkAnswer(sender: sender, showCorrectAnswerField: showCorrectAnswerField, timer: gameTimer)
        loadNextRound(delay: 2)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        timer.isHidden = false
        quizManager.loadNewGameData()
        nextRound()
    }

}
