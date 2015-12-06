//
//  Metronome.swift
//
//  Created by Roel Spruit on 16/10/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

class Metronome {

    var settings: Settings = Settings() {
        didSet{
            patternPlayer?.settings = settings
        }
    }
    
    var beatListener: ((beatType: BeatType, index: Int) -> ())?
    var stateListener: ((playing: Bool) -> ())?
    
    private var patternPlayer: PatternPlayer?
    
    init(stateListener: ((playing: Bool) -> ())? = nil, beatListener: ((beatType: BeatType, index: Int) -> ())? = nil){
        self.beatListener = beatListener
        self.stateListener = stateListener
    }
    
    /// Start the metronome
    func start(){
        
        // Make sure it's stopped first
        stop()
        
        patternPlayer = PatternPlayer(settings: settings)
        patternPlayer?.stateListener = stateListener
        patternPlayer?.beatListener = beatListener
        patternPlayer?.play()
    }
    
    /// Stop the metronome
    func stop(){
        
        if let player = patternPlayer {
            player.stop()
        }
    }
    
    /// Toggle the playing of the metronome
    func toggle(){
        
        if isPlaying {
            stop()
        }else{
            start()
        }
    }
    
    /// Returns a boolean indicating if the metronome is currently playing
    var isPlaying: Bool {
        
        if let player = patternPlayer {
            return player.isPlaying
        }
        
        return false
    }
    
}
