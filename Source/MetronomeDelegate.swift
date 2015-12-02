//
//  MetronomeDelegate.swift
//
//  Created by Roel Spruit on 02/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

protocol MetronomeDelegate {
    func metronomeDidChangeState(metronome: Metronome)
    func metronomeDidPlayBeat(metronome: Metronome, beatType: MetronomeBeatType)
}