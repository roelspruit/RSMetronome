//
//  Pattern.swift
//
//  Created by Roel Spruit on 03/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit

public struct Pattern {
    
    var iterator = 0
    var elements = [PlayableElement]()
    
    public init(elements: [PlayableElement]){
        self.elements = elements
    }
    
    public init(values: [NoteValue]){
        elements = values.map(noteWithValue)
    }
    
    public init(timeSignature: TimeSignature){
        for _ in 0...timeSignature.beats-1 {
            elements.append(noteWithValue(timeSignature.noteValue))
        }
    }
    
    private func noteWithValue(_ value: NoteValue) -> Note {
        return Note(value: value, beatType: BeatType.Beat)
    }
    
    static var QuarterNotes: Pattern {
        return Pattern(values: [.Quarter, .Quarter, .Quarter, .Quarter])
    }
}
