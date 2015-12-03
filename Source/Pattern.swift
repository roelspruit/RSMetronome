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
    
    static func withValues(values: [NoteValue]) -> Pattern {

        var p = Pattern()
        p.elements = values.map{Note(value: $0)}
        
        return p
    }
    
    static var QuarterNotes: Pattern {
        return Pattern.withValues([.Quarter, .Quarter, .Quarter, .Quarter])
    }
}
