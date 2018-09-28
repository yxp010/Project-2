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
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    let option1Index = 0
    let option2Index = 1
    let option3Index = 2
    let option4Index = 3
    var currentQuestionIndex = 0
    var secondsOnTimer = 15
    var questionArray = [Question]()
    var gameSound: SystemSoundID = 0
    var wrongAnswerSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 0
    var gameTimer: Timer!
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
        
        loadGameStartSound()
        loadCheckAnswerSound()
        playGameStartSound()
        questionsIndexesGenerator()
        displayQuestion()

    }
    
    @objc
    func countDown() {
        timer.text = String(secondsOnTimer)
        secondsOnTimer -= 1
        
        if secondsOnTimer <= 0 {
            option1Button.isEnabled = false
            option2Button.isEnabled = false
            option3Button.isEnabled = false
            option4Button.isEnabled = false
            AudioServicesPlaySystemSound(wrongAnswerSound)
            gameTimer.invalidate()
            questionsAsked += 1
            indexOfSelectedQuestion += 1
            loadNextRound(delay: 2)

        } else {
            timer.text = String(secondsOnTimer)
        }

    }
    
    // MARK: - Helpers
    func questionsIndexesGenerator() {
        let questionIndexProvider = GKShuffledDistribution.init(lowestValue: 0, highestValue: quiz.count - 1)
        for _ in 0..<questionsPerRound {
            questionArray.append(quiz[questionIndexProvider.nextInt()])
        }
    }
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav", inDirectory: "soundEffect")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    func loadCheckAnswerSound() {
        let pathOfWrongAnswerSound = Bundle.main.path(forResource: "wrongAnswerSound", ofType: "mp3", inDirectory: "soundEffect")
        let pathOfCorrectAnswerSound = Bundle.main.path(forResource: "correctAnswerSound", ofType: "wav", inDirectory: "soundEffect")
        let soundUrlOfWrongAnswerSound = URL(fileURLWithPath: pathOfWrongAnswerSound!)
        let soundUrlOfCorrectAnswerSound = URL(fileURLWithPath: pathOfCorrectAnswerSound!)
        AudioServicesCreateSystemSoundID(soundUrlOfWrongAnswerSound as CFURL, &wrongAnswerSound)
        AudioServicesCreateSystemSoundID(soundUrlOfCorrectAnswerSound as CFURL, &correctAnswerSound)
        
        
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    
    func displayQuestion() {
        
        secondsOnTimer = 15
        timer.isEnabled = true
        timer.text = String(secondsOnTimer)
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        showCorrectAnswerField.isHidden = true
        let questionDictionary = questionArray[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        playAgainButton.isHidden = true
        let optionsArray = questionDictionary.options
        let optionIndexesGenerator = GKShuffledDistribution.init(lowestValue: 0, highestValue: optionsArray.count - 1)
        var optionIndexes = [Int]()
        for _ in 0..<optionsArray.count {
            optionIndexes.append(optionIndexesGenerator.nextInt())
        }
        option1Button.setTitle(optionsArray[optionIndexes[option1Index]], for: UIControlState.normal)
        option2Button.setTitle(optionsArray[optionIndexes[option2Index]], for: UIControlState.normal)
        option3Button.setTitle(optionsArray[optionIndexes[option3Index]], for: UIControlState.normal)
        option4Button.setTitle(optionsArray[optionIndexes[option4Index]], for: UIControlState.normal)
        let optionBackgroundColor = UIColor(displayP3Red: 171/255.0, green: 89/255.0, blue: 90/255.0, alpha: 1.0)
        option1Button.backgroundColor = optionBackgroundColor
        option2Button.backgroundColor = optionBackgroundColor
        option3Button.backgroundColor = optionBackgroundColor
        option4Button.backgroundColor = optionBackgroundColor
        
        
    }
    
    func displayScore() {
        // Hide the answer buttons
        
        // Display play again button
        timer.isHidden = true
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func nextRound() {
        secondsOnTimer = 15
        if questionsAsked == questionsPerRound {
            // Game is over
            
            displayScore()
        } else {
            // Continue game
            option1Button.isEnabled = true
            option2Button.isEnabled = true
            option3Button.isEnabled = true
            option4Button.isEnabled = true
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
        
        let selectedQuestionDict = questionArray[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        if sender.currentTitle == correctAnswer {
            sender.backgroundColor = UIColor.black
            AudioServicesPlayAlertSound(correctAnswerSound)
            correctQuestions += 1
            showCorrectAnswerField.isHidden = false
            showCorrectAnswerField.text = "Good Job, you got it!"
            
        } else {
            sender.backgroundColor = UIColor.cyan
            AudioServicesPlayAlertSound(wrongAnswerSound)
            showCorrectAnswerField.isHidden = false
            showCorrectAnswerField.text = "CORRECT ANSWER: \(correctAnswer)"
        }
        
        option1Button.isEnabled = false
        option2Button.isEnabled = false
        option3Button.isEnabled = false
        option4Button.isEnabled = false
        gameTimer.invalidate()
        questionsAsked += 1
        indexOfSelectedQuestion += 1
        loadNextRound(delay: 2)
    }
    
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        timer.isHidden = false
        questionsAsked = 0
        correctQuestions = 0
        indexOfSelectedQuestion = 0
        questionArray = [Question]()
        questionsIndexesGenerator()
        nextRound()
    }
    

}

