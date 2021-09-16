//
//  Tempo.swift
//  RSMetronomeExample
//
//  Created by Roel Spruit on 07/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation


enum TempoName: String {
    case Largo      = "Largo"
    case Lento      = "Lento"
    case Adagio     = "Adagio"
    case Maestoso   = "Maestoso"
    case Andante    = "Andante"
    case Moderato   = "Moderato"
    case Allegro    = "Allegro"
    case Vivace     = "Vivace"
    case Presto     = "Presto"
    case Prestissimo = "Prestissimo"
}

public struct Tempo {
        
    private let names: [TempoName: (Int, Int)] = [
    .Largo : (40, 50),
    .Lento: (50, 60),
    .Adagio : (60, 72),
    .Maestoso : (72, 84),
    .Andante : (80, 100),
    .Moderato : (100, 120),
    .Allegro : (120, 160),
    .Vivace : (144, 160),
    .Presto : (160, 200),
    .Prestissimo : (168, 208)
    ]
    
    var bpm: Int = 0
    
    var name: String {
        
        let foundTempos = names.enumerated().filter({(index: Int, element: (TempoName, (Int, Int))) -> Bool in
            let (_, (lower, upper)) = element
            return bpm >= lower && bpm <= upper
        })
        
        let tempoNames = foundTempos
            .map { (index: Int, element: (TempoName, (Int, Int))) in
                element.0.rawValue
            }
            .sorted()
        
        return tempoNames.joined(separator: " / ")
    }
        
}
