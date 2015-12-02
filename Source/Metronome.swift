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
    
    var delegate: MetronomeDelegate?
    var settings = MetronomeSettings()
    var sounds = MetronomeSounds()
    
    /// Start the metronome
    func start(){
        
        thread = NSThread(target: self, selector: "metronomeLoop", object: nil)
        thread?.start()
        
        if let del = delegate {
            del.metronomeDidChangeState(self)
        }
    }
    
    /// Stop the metronome
    func stop(){
        
        thread?.cancel()
        thread = nil
        
        if let del = delegate {
            del.metronomeDidChangeState(self)
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
        return thread != nil
    }
    
    @objc private func metronomeLoop() {
        
        while(true) {
            
            if NSThread.currentThread().cancelled {
                NSThread.exit()
            }
            
            sounds.soundForBeatType(.DownBeat).play()
            
            if let del = delegate {
                del.metronomeDidPlayBeat(self, beatType: .DownBeat)
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
