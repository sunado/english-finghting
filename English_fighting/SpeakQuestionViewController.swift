//
//  SpeakQuestionViewController.swift
//  English_fighting
//
//  Created by hnc on 8/1/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import UIKit
import Speech
class SpeakQuestionViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backUIButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var recognizerUIButton: UIButton!
    @IBOutlet weak var recognizerLabel: UILabel!
    let networkHelper = NetWorkHelper()
    let actionHelper = QuestionViewActionHelper()
    var delegate : AnswerDelegate
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    init(delegate: AnswerDelegate){
        self.delegate = delegate
        super.init(nibName: "SpeakQuestionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @IBAction func performRecognize(_ sender: UIButton) {
        if !audioEngine.isRunning {
            startRecording()
        } else{
            audioEngine.stop()
        }
    }
    
    @IBAction func performBack(_ sender: UIButton) {
        actionHelper.comfirmEscape(delegate: delegate, view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        backgroundImageView.layer.zPosition = -1
        speechRecognizer?.delegate = self
        SFSpeechRecognizer.requestAuthorization{ (status) in
            
            var isButtonEnable = false
            
            switch status {
            case .authorized:
                isButtonEnable = true
                print("speech is accepted")
                break
            case .denied:
                print("speech is denied")
                break
            case .restricted:
                print("speech is restricted")
                break
            case .notDetermined:
                print("speech is not determined")
                break
            }
            
            OperationQueue.main.addOperation {
                self.recognizerUIButton.isEnabled = isButtonEnable
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension SpeakQuestionViewController : SFSpeechRecognizerDelegate {
    func startRecording() {
        print("startRecording")

        if self.recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
            return
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true,with: .notifyOthersOnDeactivation)
        } catch {
            print("audiosession can not set properties")
            return
        }
        
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("unable to create a SFSpeechAudioBufferRecognitionRequest")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest){ (result,err) in
            var isFinal = false
            if let result = result {
                self.recognizerLabel.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
           
            if err != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.recognizerUIButton.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer,when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch{
            print("audioEngine could not start")
        }
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.recognizerUIButton.isEnabled = true
        } else{
            self.recognizerUIButton.isEnabled = false
        }
    }
}