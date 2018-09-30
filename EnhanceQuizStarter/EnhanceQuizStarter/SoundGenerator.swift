//
//  SoundEffect.swift
//  EnhanceQuizStarter
//
//  Created by Yongnan Piao on 9/29/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox


struct GameSound {
    let path: String?
    let soundUrl: URL
    var sound: SystemSoundID = 0
    
    init(Resource: String, Type: String, directory: String) {
        self.path = Bundle.main.path(forResource: Resource, ofType: Type, inDirectory: directory)
        soundUrl = URL(fileURLWithPath: self.path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &sound)
    }
}
let gameStart = GameSound(Resource: "GameSound", Type: "wav", directory: "soundEffect")
let correctAnswer = GameSound(Resource: "correctAnswerSound", Type: "wav", directory: "soundEffect")
let wrongAnswer = GameSound(Resource: "wrongAnswerSound", Type: "mp3", directory: "soundEffect")


