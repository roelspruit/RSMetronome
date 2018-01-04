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
    @IBOutlet var tapButton: UIButton!
    
    var metronome = Metronome()
    var tapTempo = TapTempo(samples: 3)
    
    override func viewDidLoad() {
        metronome = Metronome(stateListener: metronomeDidChangeState, beatListener: metronomeDidPlayBeat)
        createBeatMachine()
    }
    
    var buttons = [UIButton]()
    
    func createBeatMachine(){
        
        var colorCount = 1
        var lightBackground = false
        
        for _ in 0...15 {
            
            let btn = UIButton()
            btn.backgroundColor = lightBackground ? UIColor.lightGray : UIColor.darkGray
            btn.addTarget(self, action: #selector(machineButtonClicked), for: .touchUpInside)
            btn.tag = lightBackground ? 1 : 0
            
            if colorCount == 4 {
                colorCount = 1
                lightBackground = !lightBackground
            }else{
                colorCount += 1
            }
            
            stackView.addArrangedSubview(btn)
            buttons.append(btn)
        }
    }
    
    @IBAction func clear(){
        for btn in buttons {
            btn.setTitle("", for: .normal)
        }
        
        createPatternFromButtons()
    }
    
    @IBAction func tap(_ sender: Any) {
        let tempo = tapTempo.tap()
        if tempo > 0 {
            tapButton.setTitle("Tap: \(tempo)", for: .normal)
        }
    }
    
    @IBAction func toggleMetronome(_ sender: Any) {
        metronome.toggle()
    }
    
    func metronomeDidChangeState(playing: Bool) {
        startStopButton.setTitle(playing ? "Stop" : "Start", for: .normal)
    }
    
    func metronomeDidPlayBeat(beatType: BeatType, index: Int) {
        
        
        if index == 0 {
            for btn in self.buttons {
                DispatchQueue.main.async() { () -> Void in
                    btn.backgroundColor = btn.tag == 1 ? UIColor.lightGray : UIColor.darkGray
                }
            }
        }
        
        let btn = self.buttons[index]
        
        DispatchQueue.main.async() { () -> Void in
            btn.backgroundColor = UIColor.red
        }
        
    }
    
    func createPatternFromButtons(){
        
        var p = [PlayableElement]()
        
        for btn in buttons {
            
            let title = btn.title(for: .normal)
            if let t = title, let i = Int(t), let value = NoteValue(rawValue: i) {
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
    
    @IBAction func machineButtonClicked(_ sender: Any) {
        
        guard let btn = sender as? UIButton else {
            return
        }
        
        let title = btn.title(for: .normal)
        if let t = title, let i = Int(t) {
            
            if i == NoteValue.Sixteenth.rawValue {
                btn.setTitle("", for: .normal)
            }else{
                btn.setTitle("\(i * 2)", for: .normal)
            }
            
        }else{
            btn.setTitle("4", for: .normal)
        }
        
        createPatternFromButtons()
    }
}

