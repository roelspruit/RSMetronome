//
//  MetronomeSettings.swift
//
//  Created by Roel Spruit on 02/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

struct MetronomeSettings {
    
    var tempo = 100
    
    /// Timeinterval in milliseconds
    var timeInterval: Double {
        let secondsBetweenBeats = 60.0 / Double(tempo)
        return secondsBetweenBeats * 1000
    }
}