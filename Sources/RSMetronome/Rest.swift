//
//  Rest.swift
//
//  Created by Roel Spruit on 03/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit

struct Rest: PlayableElement {
    var value = NoteValue.Quarter
    var beatType = BeatType.Beat
    
    init(value: NoteValue, beatType: BeatType = BeatType.Beat){
        self.value = value
        self.beatType = beatType
    }
}
