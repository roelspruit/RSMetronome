//
//  Sounds.swift
//
//  Created by Roel Spruit on 16/10/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit
import AudioToolbox

struct SoundSet {
    
    let downBeat: Sound
    let upBeat: Sound
    let beat: Sound
    
    static var clave = SoundSet(
        downBeat: Sound(fileName: "tick"),
        upBeat: Sound(fileName: "tock"),
        beat: Sound(fileName: "tock")
    )
    
    static var cowbell = SoundSet(
        downBeat: Sound(fileName: "bleep"),
        upBeat: Sound(fileName: "bleep"),
        beat: Sound(fileName: "bleep")
    )
    
    func soundForBeatType(beatType: BeatType) -> Sound {
        switch beatType {
            case .DownBeat: return downBeat
            case .UpBeat: return upBeat
            default: return beat
        }
    }
}

class Sound {

    private var soundId: SystemSoundID = 0
    
    init(fileName: String){
        
        if let soundURL = Bundle.module.url(forResource: fileName, withExtension: "caf") {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundId)
        }
    }
    
    func play(){
        AudioServicesPlaySystemSound(soundId);
    }
    
}
