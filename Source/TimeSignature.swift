//
//  TimeSignature.swift
//
//  Created by Roel Spruit on 03/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit

public struct TimeSignature {
    public var beats = 4
    public var noteValue = NoteValue.Quarter
    
    public init(beats: Int, noteValue: NoteValue) {
        self.beats = beats
        self.noteValue = noteValue
    }
}
