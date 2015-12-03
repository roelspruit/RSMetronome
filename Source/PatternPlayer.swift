//
//  PatternPlayer.swift
//  RSMetronomeExample
//
//  Created by Roel Spruit on 03/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

class PatternPlayer {

    var settings = Settings()
    
    private var sounds = Sounds()
    private var iterator = 0
    
    var beatListener: ((beatType: BeatType) -> ())?
    var stateListener: ((playing: Bool) -> ())?
    
    private var thread: NSThread?
    
    init(settings: Settings){
        self.settings = settings
    }
    
    func play(){

        thread = NSThread(target: self, selector: "loop", object: nil)
        thread?.start()
        
        notifyStateListener()
    }
    
    func stop(){
        
        thread?.cancel()
        thread = nil
        
        notifyStateListener()
    }
    
    var isPlaying: Bool {
        
        if let t = thread {
            return !t.cancelled
        }
        
        return false
    }
    
    private func notifyStateListener(){
        if let listener = stateListener {
            listener(playing: isPlaying)
        }
    }
    
    private func nextElement() -> PlayableElement? {
        iterator++
        
        if iterator >= settings.pattern.elements.count {
            iterator = 0
        }
        
        return settings.pattern.elements[iterator]
    }
    
    @objc private func loop() {
        
        while(true && !NSThread.currentThread().cancelled) {
            
            guard let element = nextElement() else{
                stop()
                continue
            }
            
            if element is Note {
                playElement(element)
            }
            
            waitForElement(element)
        }
        
        NSThread.exit()
    }
    
    private func playElement(element: PlayableElement){
        
        let beatType = iterator == 0 ? BeatType.DownBeat : BeatType.UpBeat
        
        sounds.soundForBeatType(beatType).play()
        
        if let listener = beatListener {
            listener(beatType: beatType)
        }
    }
    
    private func waitForElement(element: PlayableElement){
        let nanoSecondsInterval = element.value.nanoSecondsWithTempo(settings.tempo, tempoNote: settings.tempoNote)
        mach_wait_until(mach_absolute_time() + nanoSecondsInterval)
    }
}
