//
//  MetronomeSound.swift
//
//  Created by Roel Spruit on 16/10/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit
import AudioToolbox

struct MetronomeSounds {
    let Tick = MetronomeSound(fileName: "tick")
    let Tock = MetronomeSound(fileName: "tock")
    
    func soundForBeatType(beatType: MetronomeBeatType) -> MetronomeSound {
        
        switch beatType {
            
        case .DownBeat:
            return Tick
            
        default:
            return Tock
        }
    }
}

class MetronomeSound{

    private var soundId: SystemSoundID = 0
    
    init(fileName: String){
        
        if let soundURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: "caf") {            
            AudioServicesCreateSystemSoundID(soundURL, &soundId)
        }
    }
    
    func play(){
        AudioServicesPlaySystemSound(soundId);
    }
    
}