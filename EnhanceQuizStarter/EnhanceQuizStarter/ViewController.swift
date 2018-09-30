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
    let soundManager = SoundManager(sound: soundEffects)
    var gameTimer: Timer!
    let quizManager = QuizManager(quiz: quiz)
    var buttons = [UIButton]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var showCorrectAnswerField: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createOptionButtonsArray()
        quizManager.startGame()
        soundManager.playStartGameSound()
        displayQuestion()
        

    }
    
    // MARK: - Helpers
    
    // Make an Array for all option buttons.
    func createOptionButtonsArray() {
        buttons.append(option1Button)
        buttons.append(option2Button)
        buttons.append(option3Button)
        buttons.append(option4Button)
    }
    
    // Make a countDonw function for timer use.
    // If the time runs out, the game goes to next round.
    @objc
    func countDown() {
        secondsOnTimer -= 1
        timer.text = String(secondsOnTimer)
        if secondsOnTimer <= 0 {
            for button in buttons {
                button.isEnabled = false
            }
            soundManager.playStartGameSound()
            gameTimer.invalidate()
            quizManager.questionsAsked += 1
            quizManager.indexOfCurrentQuestion += 1
            loadNextRound(delay: 2)
            
        } else {
            timer.text = String(secondsOnTimer)
        }
        
    }
    
    func displayQuestion() {
        
        secondsOnTimer = 15
        playAgainButton.isHidden = true
        timer.isEnabled = true
        showCorrectAnswerField.isHidden = true
        
        //Start the Timer.
        timer.text = String(secondsOnTimer)
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        //Select and display current round question.
        let currentQuestionIndex = quizManager.indexOfCurrentQuestion
        let currentRoundQuestion = quizManager.questionsArray[currentQuestionIndex]
        questionField.text = currentRoundQuestion.question
        
        //Create a random options Index to get the options from the currentRoundQuestion.option for each option button. It makes that the options showing on the buttons are placed in different positions each time.
        
        quizManager.createOptionsArray(question: currentRoundQuestion)
        let optionsArray = quizManager.options
       
        for (index, button) in buttons.enumerated() {
            button.setTitle(optionsArray[index], for: UIControlState.normal)
        }
        
        let optionBackgroundColor = UIColor(displayP3Red: 171/255.0, green: 89/255.0, blue: 90/255.0, alpha: 1.0)
        
        for button in buttons {
            button.backgroundColor = optionBackgroundColor
        }
        
    }
    
    func nextRound() {
        secondsOnTimer = 15
        if quizManager.questionsAsked == quizManager.questionsPerRound {
            // Game is over
            
            quizManager.displayScore(timerField: timer, playAgainButton: playAgainButton, questionField: questionField)
        } else {
            // Continue game
            for button in buttons {
                button.isEnabled = true
            }
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        
        quizManager.checkAnswer(sender, options: buttons, showCorrectAnswerField: showCorrectAnswerField, timer: gameTimer)

        loadNextRound(delay: 2)
    }
    
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        timer.isHidden = false
        quizManager.startGame()
        nextRound()
    }
    

}

