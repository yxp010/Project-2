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
    var questionArray = [Question]()
    
    var gameSound: SystemSoundID = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        playGameStartSound()
        let questionIndexProvider = GKShuffledDistribution.init(lowestValue: 0, highestValue: quiz.count - 1)
        for _ in 0..<questionsPerRound {
            questionArray.append(quiz[questionIndexProvider.nextInt()])
        }
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    func loadCheckAnswerSound() {
        
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func displayQuestion() {
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
        
        
    }
    
    func displayScore() {
        // Hide the answer buttons
        option1Button.isHidden = true
        option2Button.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
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
        questionsAsked += 1
        
        let selectedQuestionDict = questionArray[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        questionField.text = correctAnswer
        if sender.currentTitle == correctAnswer {
            sender.backgroundColor = UIColor.black
            playAgainButton.setTitle("Correct", for:
                UIControlState.normal)
            
        } else {
            sender.backgroundColor = UIColor.cyan
            playAgainButton.setTitle("Wrong", for: UIControlState.normal)
            
        }
        
        indexOfSelectedQuestion += 1
        loadNextRound(delay: 2)
    }
    
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        option1Button.isHidden = false
        option2Button.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

}

