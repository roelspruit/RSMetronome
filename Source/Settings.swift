//
//  Settings.swift
//
//  Created by Roel Spruit on 02/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

struct Settings {
    
    var timeSignature = TimeSignature(beats: 4, noteValue: .Quarter)
    var tempo = 100
    var tempoNote = NoteValue.Quarter
    var pattern = Pattern.QuarterNotes
}