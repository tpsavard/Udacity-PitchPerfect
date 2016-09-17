//
//  RecordViewController.swift
//  PitchPerfect
//
//  Created by Savard, Tim on 7/19/16.
//  Copyright © 2016 Savard, Tim. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordAudioButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
        
        stopRecordingButton.enabled = false
    }


    @IBAction func recordAudio(sender: AnyObject) {
        print("recordAudio called")
        
        updateRecordingUI()
        
        // Get filepath for audio recording output
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let fileName = "recording.wav"
        let filePathArray = [dirPath, fileName]
        let filePath = NSURL.fileURLWithPathComponents(filePathArray)!
        
        print("Recording to " + filePath.absoluteString)
        
        // Get audio source
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // Record audio
        try! audioRecorder = AVAudioRecorder(URL: filePath, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        print("stopRecording called")
        
        updateRecordingUI()
        
        // Stop recording, release audio source
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audioRecorderDidFinishRecording called")
        
        // Transition to the playback view
        if (flag) {
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("Error: Recording failed")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playbackViewController = segue.destinationViewController as! PlaybackViewController
            let audioFilepath = sender as! NSURL
            playbackViewController.recordedAudioURL = audioFilepath
        }
    }
    
    func updateRecordingUI() {
        recordingLabel.text = (recordAudioButton.enabled ? "Recording in Progress" : "Tap to Record")
        recordAudioButton.enabled = !recordAudioButton.enabled
        stopRecordingButton.enabled = !stopRecordingButton.enabled
    }
    
}

