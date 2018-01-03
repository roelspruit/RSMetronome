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
    private var iterator = -1
    
    var beatListener: ((_ beatType: BeatType, _ index: Int) -> ())?
    var stateListener: ((_ playing: Bool) -> ())?
    
    private var thread: Thread?
    
    init(settings: Settings){
        self.settings = settings
    }
    
    func play(){

        thread = Thread(target: self, selector: "loop", object: nil)
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
            return !t.isCancelled
        }
        
        return false
    }
    
    private func notifyStateListener(){
        if let listener = stateListener {
            listener(isPlaying)
        }
    }
    
    private func nextElement() -> PlayableElement? {
        iterator += 1
        
        if iterator >= settings.pattern.elements.count {
            iterator = 0
        }
        
        return settings.pattern.elements[iterator]
    }
    
    @objc private func loop() {
        
        while(true && !Thread.current.isCancelled) {
            
            guard let element = nextElement() else{
                stop()
                continue
            }
            
            if element is Note {
                playElement(element: element)
            }
            
            if let listener = beatListener {
                listener(element.beatType, iterator)
            }
            
            waitForElement(element: element)
        }
        
        Thread.exit()
    }
    
    private func playElement(element: PlayableElement){
        
        sounds.soundForBeatType(beatType: element.beatType).play()
        
    }
    
    private func waitForElement(element: PlayableElement){
        let nanoSecondsInterval = element.value.nanoSecondsWithTempo(tempo: settings.tempo, tempoNote: settings.tempoNote)
        mach_wait_until(mach_absolute_time() + nanoSecondsInterval)
    }
}
