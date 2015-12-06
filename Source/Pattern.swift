//
//  Pattern.swift
//
//  Created by Roel Spruit on 03/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit

struct Pattern {
    
    var iterator = 0
    var elements = [PlayableElement]()
    
    init(elements: [PlayableElement]){
        self.elements = elements
    }
    
    init(values: [NoteValue]){
        elements = values.enumerate().map(noteWithIndex)
    }
    
    init(timeSignature: TimeSignature){
        for var i = 0; i < timeSignature.beats; i++ {
            elements.append(noteWithIndex(i, value: timeSignature.noteValue))
        }
    }
    
    private func noteWithIndex(index: Int, value: NoteValue) -> Note{
        let beatType = index == 0 ? BeatType.DownBeat : BeatType.Beat
        return Note(value: value, beatType: beatType)
    }
    
    static var QuarterNotes: Pattern {
        return Pattern(values: [.Quarter, .Quarter, .Quarter, .Quarter])
    }
}