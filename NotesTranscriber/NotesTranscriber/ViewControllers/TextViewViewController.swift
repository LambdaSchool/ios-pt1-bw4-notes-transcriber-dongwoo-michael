//
//  TextViewViewController.swift
//  NotesTranscriber
//
//  Created by Dongwoo Pae on 12/20/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import Speech

class TextViewViewController: UIViewController, SFSpeechRecognizerDelegate {

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()

    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add authorization here
        speechRecognizer.delegate = self
        self.updateViews()
    }
    

    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            print("unable to create recognitionRequest")
            return
        }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = true
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            
            //error is not nil all the time so either (result && error) || (error)
            if error != nil {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
                //when there is no speech to convert into text, this will be called and the button will be changed
                self.recordButton.setImage(UIImage(named: "Record"), for: [])
                print("nothing to do speech-to-text here")
            } else {
                guard let result = result else {return}
                // Update the text view with the results.
                
                self.textView.text = result.bestTranscription.formattedString
            }
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        self.textView.text = "Start your speech"
    }
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            //this is key to reset
            self.recognitionTask?.cancel()
            //add styleSheet here
            if self.textView.text != "Start your speech" {
                shareText()
            }
        } else {
            do {
                try startRecording()
                recordButton.setImage(UIImage(named: "Stop"), for: .normal)
            } catch {
                recordButton.setTitle("Recording Not Available", for: [])
            }
        }
    }
    
    
    //CRUD methods and updateViews
    var noteController: NoteController?
    
    var note: Note? {
        didSet {
            self.updateViews()
        }
    }
    
    private func shareText() {
        guard let noteInput = self.textView.text else {
            print("no text found")
            return
        }
        let vc = UIActivityViewController(activityItems: [noteInput], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let noteController = self.noteController,
            let note = self.note {
            if let noteText = self.textView.text {
                noteController.updateNote(for: note, noteText: noteText)
            }
        } else {
            guard let noteInput = self.textView.text else {return}
            noteController?.createNote(for: noteInput)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        if let note = self.note {
            self.textView?.text = note.noteText
        } else {
            print("no data being passed")
        }
    }
}
