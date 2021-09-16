//
//  NoteValue.swift
//
//  Created by Roel Spruit on 03/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

public enum NoteValue: Int {
    
    case ThirtySecond  = 32
    case Sixteenth  = 16
    case Eight      = 8
    case Quarter    = 4
    case Half       = 2
    case Whole      = 1
    
    func numberOfNotesInNote(note: NoteValue) -> Int{
        return self.rawValue / note.rawValue
    }
    
    func nanoSecondsWithTempo(tempo: Int, tempoNote: NoteValue) -> UInt64 {

        let nanoSecondsPerMilliSecond = 1000000.0
        let milliSecondsPerSecond = 1000.0
        
        let secondsBetweenBeats = 60.0 / Double(tempo)
        let secondsForNote = secondsBetweenBeats / Double(numberOfNotesInNote(note: tempoNote))
        
        return UInt64(secondsForNote * milliSecondsPerSecond * nanoSecondsPerMilliSecond)
    }
}
