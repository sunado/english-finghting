//
//  ChooseQuestionController.swift
//  English_fighting
//
//  Created by hnc on 7/24/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import UIKit
class ChooseQuestionController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var Hintbtn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var abtn: UIButton!
    @IBOutlet weak var bbtn: UIButton!
    @IBOutlet weak var cbtn: UIButton!
    @IBOutlet weak var dbtn: UIButton!
    var isQuestionLoaded: Bool?
    let netWorkHelper = NetWorkHelper()
    let actionHelper = QuestionViewActionHelper()
    let delegate: AnswerDelegate
    
    init(delegate: AnswerDelegate){
        self.delegate = delegate
        super.init(nibName: "ChooseQuestionController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func perform(_ sender: UIButton) {
        switch sender {
        case backbtn:
            actionHelper.comfirmEscape(delegate: delegate,view: self)
            break
        case abtn:
            actionHelper.showRightAnswerAlert(delegate: delegate,view: self)
            break
        case bbtn:
            actionHelper.showWrongAnswerAlert(delegate: delegate,view: self)
            break
        case cbtn:
            actionHelper.showWrongAnswerAlert(delegate: delegate,view: self)
            break
        case dbtn:
            actionHelper.showWrongAnswerAlert(delegate: delegate,view: self)
            break
        default:
            break
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
        setBorder(layer: backbtn.layer,width: 1,radius: 3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isQuestionLoaded == nil  {
            netWorkHelper.loadQuestion(id: 1, type: DataManager.CHOOSEQUESTION){ json in
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
                    self.isQuestionLoaded = true
                    self.viewDidLoad()
                    self.viewWillAppear(self.isQuestionLoaded!)
                }
                
            }
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    func setBorder(layer: CALayer,width: CGFloat = 1,color: CGColor = UIColor.white.cgColor,radius: CGFloat = 10){
        layer.borderWidth = width
        layer.borderColor = color
        layer.cornerRadius = radius
    }
}
