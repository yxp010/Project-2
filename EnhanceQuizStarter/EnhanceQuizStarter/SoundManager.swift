//
//  SoundManager.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/29/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

// A struct that have different 'sounds: SystemSoundID' as properties.
// It also have functions play different sound base on the name.

struct SoundManager {
    let gameStartSound = gameStart.sound
    let corrctAnswerSound = correctAnswer.sound
    let wrongAnswerSound = wrongAnswer.sound
    
    
    func playWrongAnswerSound() {
        AudioServicesPlayAlertSound(wrongAnswerSound)
    }
    func playCorrctAnswerSound() {
        AudioServicesPlaySystemSound(corrctAnswerSound)
    }
    func playGameStartsound() {
        AudioServicesPlaySystemSound(gameStartSound)
    }
}
