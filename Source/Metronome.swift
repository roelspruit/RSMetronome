//
//  Metronome.swift
//
//  Created by Roel Spruit on 16/10/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

class Metronome {

    private var thread: NSThread?
    private let nanoSecondsPerMilliSecond = 1000000.0
    
    var beatListener: ((beatType: MetronomeBeatType) -> ())?
    var stateListener: ((playing: Bool) -> ())?
    
    var settings = MetronomeSettings()
    var sounds = MetronomeSounds()
    
    /// Start the metronome
    func start(){
        
        thread = NSThread(target: self, selector: "metronomeLoop", object: nil)
        thread?.start()
        
        notifyStateListener()
    }
    
    /// Stop the metronome
    func stop(){
        
        thread?.cancel()
        thread = nil
        
        notifyStateListener()
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
        return thread != nil
    }
    
    private func notifyStateListener(){
        if let listener = stateListener {
            listener(playing: isPlaying)
        }
    }
    
    @objc private func metronomeLoop() {
        
        while(true) {
            
            if NSThread.currentThread().cancelled {
                NSThread.exit()
            }
            
            let beatType = MetronomeBeatType.DownBeat
            sounds.soundForBeatType(beatType).play()
            
            if let listener = beatListener {
                listener(beatType: beatType)
            }
            
            wait()
        }
    }
    
    private func wait(){
        let millisInterval = settings.timeInterval
        let intervalInNanoseconds = UInt64(millisInterval * nanoSecondsPerMilliSecond)
        mach_wait_until(mach_absolute_time() + intervalInNanoseconds)
    }
    
}
