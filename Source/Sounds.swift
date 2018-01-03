//
//  Sounds.swift
//
//  Created by Roel Spruit on 16/10/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit
import AudioToolbox

struct Sounds {
    let Tick = Sound(fileName: "tick")
    let Tock = Sound(fileName: "tock")
    
    func soundForBeatType(beatType: BeatType) -> Sound {
        
        switch beatType {
            
        case .DownBeat:
            return Tick
            
        default:
            return Tock
        }
    }
}

class Sound {

    private var soundId: SystemSoundID = 0
    
    init(fileName: String){
        
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: "caf") {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundId)
        }
    }
    
    func play(){
        AudioServicesPlaySystemSound(soundId);
    }
    
}
