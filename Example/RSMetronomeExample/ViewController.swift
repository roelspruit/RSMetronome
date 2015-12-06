//
//  ViewController.swift
//  RSMetronomeExample
//
//  Created by Roel Spruit on 02/12/15.
//  Copyright © 2015 DinkyWonder. All rights reserved.
//

import UIKit

class DrumMachineButton: UIControl {
    var noteValue: NoteValue?
}

class ViewController: UIViewController{
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var startStopButton: UIButton!
    
    var metronome = Metronome()
    var tapTempo = TapTempo()
    
    override func viewDidLoad() {
        metronome = Metronome(stateListener: metronomeDidChangeState, beatListener: metronomeDidPlayBeat)
        createBeatMachine()
    }
    
    var buttons = [UIButton]()
    
    func createBeatMachine(){
        
        var colorCount = 1
        var lightBackground = false
        
        for var i = 0; i < 16; i++ {
            
            let btn = UIButton()
            btn.backgroundColor = lightBackground ? UIColor.lightGrayColor() : UIColor.darkGrayColor()
            btn.addTarget(self, action: Selector("machineButtonClicked:"), forControlEvents: .TouchUpInside)
            btn.tag = lightBackground ? 1 : 0
            
            if colorCount == 4 {
                colorCount = 1
                lightBackground = !lightBackground
            }else{
                colorCount++
            }
            
            stackView.addArrangedSubview(btn)
            buttons.append(btn)
        }
    }
    
    @IBAction func clear(){
        for btn in buttons {
            btn.setTitle("", forState: .Normal)
        }
        
        createPatternFromButtons()
    }
    
    @IBAction func tap(sender: AnyObject) {
        tapTempo.tap()
    }
    
    @IBAction func toggleMetronome(sender: AnyObject) {
        metronome.toggle()
    }
    
    func metronomeDidChangeState(playing: Bool) {
        startStopButton.setTitle(playing ? "Stop" : "Start", forState: .Normal)
    }
    
    func metronomeDidPlayBeat(beatType: BeatType, index: Int) {
        
        
        if index == 0 {
            for btn in self.buttons {
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    btn.backgroundColor = btn.tag == 1 ? UIColor.lightGrayColor() : UIColor.darkGrayColor()
                }
            }
        }
        
        let btn = self.buttons[index]
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            btn.backgroundColor = UIColor.redColor()
        }
        
    }
    
    func createPatternFromButtons(){
        
        var p = [PlayableElement]()
        
        for btn in buttons {
            
            let title = btn.titleForState(.Normal)
            if let t = title, i = Int(t), value = NoteValue(rawValue: i) {
                p.append(Note(value: value))
            }else{
                p.append(Rest(value: .Sixteenth))
            }
        }
        
        var settings = metronome.settings
        settings.pattern = Pattern(elements: p)
        metronome.settings = settings
        
        if !metronome.isPlaying{
            metronome.start()
        }
    }
    
    @IBAction func machineButtonClicked(sender: UIButton) {
        
        let title = sender.titleForState(.Normal)
        if let t = title, i = Int(t) {
            
            if i == NoteValue.Sixteenth.rawValue {
                sender.setTitle("", forState: .Normal)
            }else{
                sender.setTitle("\(i * 2)", forState: .Normal)
            }
            
        }else{
            sender.setTitle("4", forState: .Normal)
        }
        
        createPatternFromButtons()
    }
}

