//
//  PlaybackViewController.swift
//  PitchPerfect
//
//  Created by Savard, Tim on 7/25/16.
//  Copyright © 2016 Savard, Tim. All rights reserved.
//

import UIKit
import AVFoundation

class PlaybackViewController: UIViewController {

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int { case Snail = 0, Rabbit, Chipmunk, Vader, Echo, Reverb }
    
    @IBAction func playSound(sender: UIButton) {
        print("playSound called, with tag " + String(sender.tag))
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Snail:
            playSound(rate: 0.5)
        case .Rabbit:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        configureUI(.Playing)
    }
    
    @IBAction func stopSound(sender: UIButton) {
        print("stopSound called")
        
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad called")

        setupAudio()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
        
        configureUI(.NotPlaying)
    }

}
