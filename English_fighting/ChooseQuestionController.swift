//
//  ChooseQuestionController.swift
//  English_fighting
//
//  Created by hnc on 7/24/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import UIKit
class ChooseQuestionController: AbstractQuestionViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var Hintbtn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var abtn: UIButton!
    @IBOutlet weak var bbtn: UIButton!
    @IBOutlet weak var cbtn: UIButton!
    @IBOutlet weak var dbtn: UIButton!
    @IBOutlet weak var progressView : UIProgressView!
    var isQuestionLoaded: Bool?
    let netWorkHelper = NetWorkHelper()
    var answer: Int?
    init(delegate: AnswerDelegate){
        super.init(nibName: "ChooseQuestionController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func perform(_ sender: UIButton) {
        switch sender {
        case backbtn:
            comfirmEscape()
            break
        case abtn:
            showResult(pos: 1)
            break
        case bbtn:
            showResult(pos: 2)
            break
        case cbtn:
            showResult(pos: 3)
            break
        case dbtn:
            showResult(pos: 4)
            break
        default:
            break
        }
    }
    func showResult(pos:Int){
        if let answer = answer {
            if answer == pos {
                showRightAnswerAlert()
            } else {
                showWrongAnswerAlert()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.layer.zPosition = -1
        setBorder(layer: questionLabel.layer)
        setBorder(layer: abtn.layer)
        setBorder(layer: bbtn.layer)
        setBorder(layer: cbtn.layer)
        setBorder(layer: dbtn.layer)
        progressView.setProgress(1, animated: false)
        //setBorder(layer: backbtn.layer,width: 1,radius: 3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isQuestionLoaded == nil  {
            let id = DataManager.randQuestion(type: DataManager.CHOOSEQUESTION)
            netWorkHelper.loadQuestion(id: id, type: DataManager.CHOOSEQUESTION){ json in
                let question = ChooseQuestion.create(data: json)
                if let question = question {
                    print("finish load")
                    DispatchQueue.main.async {
                        self.questionLabel.text = question.question
                        self.abtn.setTitle(question.answerA, for: .normal)
                        self.bbtn.setTitle(question.answerB, for: .normal)
                        self.cbtn.setTitle(question.answerC, for: .normal)
                        self.dbtn.setTitle(question.answerD, for: .normal)
                    }
                    self.answer = question.answer
                    self.isQuestionLoaded = true
                    self.viewDidLoad()
                    self.viewWillAppear(self.isQuestionLoaded!)
                }
                
            }
        }
        self.navigationController?.navigationBar.isHidden = true
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
