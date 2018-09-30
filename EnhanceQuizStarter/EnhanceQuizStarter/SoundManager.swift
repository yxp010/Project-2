//
//  SoundManager.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/29/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundManager {
    let sounds: AllSounds
    
    
    init(sound: AllSounds) {
        self.sounds = sound
    }
    func playStartGameSound() {
        AudioServicesPlaySystemSound(sounds.gameStartSound)
    }
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(sounds.corrctAnswerSound)
    }
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(sounds.wrongAnswerSound)
    }
    

}
