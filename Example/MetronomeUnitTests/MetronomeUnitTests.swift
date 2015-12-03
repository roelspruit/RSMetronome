//
//  MetronomeUnitTests.swift
//  MetronomeUnitTests
//
//  Created by Roel Spruit on 02/12/15.
//  Copyright (c) 2015 DinkyWonder. All rights reserved.
//

import UIKit
import XCTest

@testable import RSMetronomeExample

class MetronomeUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMetronomeStart(){
        
        let metronome = Metronome()
        metronome.start()
        
        let tickExpectation = expectationWithDescription("metronomeTick")
        
        metronome.beatListener = { (beatType: MetronomeBeatType) in
            tickExpectation.fulfill()
        }
        
        
        waitForExpectationsWithTimeout(1.0) { (error) -> Void in }
        
    }
    
}