//
//  ViewController.swift
//  RSMetronomeExample
//
//  Created by Roel Spruit on 02/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MetronomeDelegate {

    @IBOutlet var flashView: UIView!
    @IBOutlet var startStopButton: UIButton!
    
    let metronome = Metronome()
    
    override func viewDidLoad() {
        metronome.delegate = self
    }
    
    @IBAction func toggleMetronome(sender: AnyObject) {
        metronome.toggle()
    }

    // MetronomeDelegate
    
    func metronomeDidChangeState(metronome: Metronome) {
        startStopButton.setTitle(metronome.isPlaying ? "Stop" : "Start", forState: .Normal)
    }
    
    func metronomeDidPlayBeat(metronome: Metronome, beatType: MetronomeBeatType) {
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

