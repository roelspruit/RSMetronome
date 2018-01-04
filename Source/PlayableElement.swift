//
//  PlayableElement.swift
//
//  Created by Roel Spruit on 03/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import Foundation

public protocol PlayableElement {
    var value: NoteValue { get }
    var beatType: BeatType { get }
}
