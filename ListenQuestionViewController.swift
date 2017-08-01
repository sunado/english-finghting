//
//  ListenQuestionViewController.swift
//  English_fighting
//
//  Created by hnc on 7/31/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import UIKit
import AVFoundation
class ListenQuestionViewController: UIViewController {

    @IBOutlet weak var backUIButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aUIButton: UIButton!
    @IBOutlet weak var bUIButton: UIButton!
    @IBOutlet weak var cUIButton: UIButton!
    @IBOutlet weak var dUIButton: UIButton!
    @IBOutlet weak var backgroundUIImageView: UIImageView!
    var delegate: AnswerDelegate
    let actionHelper = QuestionViewActionHelper()
    var isQuestionLoaded: Bool?
    let netWorkHelper = NetWorkHelper()
    let speaker = AVSpeechSynthesizer()
    var utterance: AVSpeechUtterance?
    var speakerLock = false
    init(delegate: AnswerDelegate){
        self.delegate = delegate
        super.init(nibName: "ListenQuestionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func chooseAnswerPerform(_ sender: UIButton) {
        switch sender {
        case aUIButton:
            actionHelper.showWrongAnswerAlert(delegate: delegate,view: self)
            break
        case bUIButton:
            actionHelper.showRightAnswerAlert(delegate: delegate,view: self)
            break
        case cUIButton:
            actionHelper.showWrongAnswerAlert(delegate: delegate,view: self)
            break
        case dUIButton:
            break
        case backUIButton:
            actionHelper.comfirmEscape(delegate: delegate, view: self)
        default:
            break
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
        setBorder(layer: backUIButton.layer,width: 1,color: UIColor.white.cgColor,radius: 0)
        
        self.speaker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isQuestionLoaded == nil {
            netWorkHelper.loadQuestion(id: 1, type: DataManager.LISTENQUESTION){ json in
                let question = ListenQuestion.create(data: json)
                if let question = question {
                    DispatchQueue.main.async {
                        self.aUIButton.setTitle(question.answerA, for: .normal)
                        self.bUIButton.setTitle(question.answerB, for: .normal)
                        self.cUIButton.setTitle(question.answerC, for: .normal)
                        self.dUIButton.setTitle(question.answerD, for: .normal)
                    }
                    self.utterance = AVSpeechUtterance(string: question.question)
                    self.utterance?.voice = AVSpeechSynthesisVoice(language: "en-US")
                    self.utterance?.rate = 0.5
                    self.utterance?.pitchMultiplier = 1.2
                    self.isQuestionLoaded = true
                    self.viewDidLoad()
                    self.viewWillAppear(animated)
                }
            }
            
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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







