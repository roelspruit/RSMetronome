//
//  TapTempo.swift
//  RSMetronomeExample
//
//  Created by Roel Spruit on 06/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

class TapTempo {
    
    var maximumSamples = 3
    
    private var samples = [TimeInterval]()
    private var lastTap: Date?
    
    init(samples: Int = 3){
       maximumSamples = samples
    }
    
    var tempo: Int {
        
        guard !samples.isEmpty else {
            return 0
        }
        
        let averageTimeInterval = samples.reduce(0, +) / Double(samples.count)
        let bpm = Int(60.0 / averageTimeInterval)
        return bpm
    }
    
    func tap() -> Int{
        
        let currentDate = Date()
        
        if let last = lastTap {
            
            samples.insert(currentDate.timeIntervalSince(last), at: 0)
            
            if(samples.count > maximumSamples){
                samples.removeLast()
            }
        }
        
        lastTap = currentDate
        
        return tempo
    }

}
