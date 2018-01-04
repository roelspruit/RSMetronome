//
//  Settings.swift
//
//  Created by Roel Spruit on 02/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

public struct Settings {
    
    public var timeSignature = TimeSignature(beats: 4, noteValue: .Quarter)
    public var tempo = 100
    public var tempoNote = NoteValue.Quarter
    public var pattern = Pattern.QuarterNotes
}
