//
//  ListenQuestionViewController.swift
//  English_fighting
//
//  Created by hnc on 7/31/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import UIKit
import AVFoundation
class ListenQuestionViewController: AbstractQuestionViewController {

    @IBOutlet weak var backUIButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aUIButton: UIButton!
    @IBOutlet weak var bUIButton: UIButton!
    @IBOutlet weak var cUIButton: UIButton!
    @IBOutlet weak var dUIButton: UIButton!
    @IBOutlet weak var backgroundUIImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    var isQuestionLoaded: Bool?
    let netWorkHelper = NetWorkHelper()
    let speaker = AVSpeechSynthesizer()
    var utterance: AVSpeechUtterance?
    var speakerLock = false
    init(delegate: AnswerDelegate){
        super.init(nibName: "ListenQuestionViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func chooseAnswerPerform(_ sender: UIButton) {

        let base = sender.currentTitle
        if let base = base {
            let index = base.index(base.startIndex, offsetBy: 3)
            let new = base.substring(from: index).trimmingCharacters(in: .whitespaces)
            if let question = utterance?.speechString.trimmingCharacters(in: .whitespaces) {
                print("question: \(question) answer: \(new)")
                if new == question {
                    showRightAnswerAlert()
                } else{
                    showWrongAnswerAlert()
                }
            }
        }
    }
    
    @IBAction func playBtnPerform(_ sender: UIButton) {
        if speakerLock == false, let utterance = self.utterance {
            speakerLock = true
            self.speaker.speak(utterance)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        backgroundUIImageView.layer.zPosition = -1
        setBorder(layer: aUIButton.layer,radius: aUIButton.frame.size.height/2)
        setBorder(layer: bUIButton.layer,radius: aUIButton.frame.size.height/2)
        setBorder(layer: cUIButton.layer,radius: aUIButton.frame.size.height/2)
        setBorder(layer: dUIButton.layer,radius: aUIButton.frame.size.height/2)
        //setBorder(layer: backUIButton.layer,width: 1,color: UIColor.white.cgColor,radius: 0)
        progressView.setProgress(1, animated: true)
        //loading overlay
        //actionHelper.showLoadingOverlay(view: self)
        
        //load question
        let id = DataManager.randQuestion(type: DataManager.LISTENQUESTION)
        netWorkHelper.loadQuestion(id: id, type: DataManager.LISTENQUESTION){ json in
            let question = ListenQuestion.create(data: json)
            if let question = question {
                DispatchQueue.main.async {
                    self.aUIButton.setTitle(question.answerA, for: .normal)
                    self.bUIButton.setTitle(question.answerB, for: .normal)
                    self.cUIButton.setTitle(question.answerC, for: .normal)
                    self.dUIButton.setTitle(question.answerD, for: .normal)
                    //self.actionHelper.hideLoadingOverlay()
                }
                self.utterance = AVSpeechUtterance(string: question.question)
                self.utterance?.voice = AVSpeechSynthesisVoice(language: "en-US")
                self.utterance?.rate = 0.5
                self.utterance?.pitchMultiplier = 1.2
                //stop overlay
            
                
            }
        }
            
        //set delegate
        self.speaker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startCountDown(with: progressView)
    }
    
    func setBorder(layer: CALayer,width: CGFloat = 1,color: CGColor = UIColor.white.cgColor,radius: CGFloat = 10){
        layer.borderWidth = width
        layer.borderColor = color
        layer.cornerRadius = radius
    }
}

extension ListenQuestionViewController : AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("spkeak finished")
        speakerLock = false
    }
}







