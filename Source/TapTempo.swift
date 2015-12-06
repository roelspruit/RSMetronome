//
//  TapTempo.swift
//  RSMetronomeExample
//
//  Created by Roel Spruit on 06/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

class TapTempo {
    
    var maximumSamples = 4
    
    private var samples = [NSTimeInterval]()
    private var lastTap: NSDate?
    
    init(samples: Int = 4){
       maximumSamples = samples
    }
    
    var tempo: Int {
        guard !samples.isEmpty else {
            return 0
        }
        
        let averageTimeInterval = samples.reduce(0, combine: +) / Double(samples.count)
        let bpm = Int(60.0 / averageTimeInterval)
        return bpm
    }
    
    func tap(){
        
        let currentDate = NSDate()
        
        if let last = lastTap {
            
            samples.insert(currentDate.timeIntervalSinceDate(last), atIndex: 0)
            
            if(samples.count > maximumSamples){
                samples.removeLast()
            }
        }
        
        lastTap = currentDate
    }

}
