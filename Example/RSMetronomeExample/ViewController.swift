//
//  ViewController.swift
//  RSMetronomeExample
//
//  Created by Roel Spruit on 02/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet var flashView: UIView!
    @IBOutlet var startStopButton: UIButton!
    
    var metronome = Metronome()
    
    override func viewDidLoad() {
        metronome = Metronome(stateListener: metronomeDidChangeState, beatListener: metronomeDidPlayBeat)
    }
    
    @IBAction func toggleMetronome(sender: AnyObject) {
        metronome.toggle()
    }

    // MetronomeDelegate
    
    func metronomeDidChangeState(playing: Bool) {
        startStopButton.setTitle(playing ? "Stop" : "Start", forState: .Normal)
    }
    
    func metronomeDidPlayBeat(beatType: BeatType) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if self.flashView.tag == 0 {
                self.flashView.tag = 1
                self.flashView.backgroundColor = UIColor.redColor()
            }else{
                self.flashView.tag = 0
                self.flashView.backgroundColor = UIColor.greenColor()
            }
        }
    }
}

