//
//  ChooseQuestionController.swift
//  English_fighting
//
//  Created by hnc on 7/24/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import UIKit
class ChooseQuestionController: UIViewController {
    
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var Hintbtn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var abtn: UIButton!
    @IBOutlet weak var bbtn: UIButton!
    @IBOutlet weak var cbtn: UIButton!
    @IBOutlet weak var dbtn: UIButton!
    var isQuestionLoaded: Bool?
    
    var questions: [ChooseQuestion] = []
    
    
    @IBAction func perform(_ sender: UIButton) {
        switch sender {
        case backbtn:
            self.navigationController?.popViewController(animated: true)
            break
        case abtn:
            break
        case bbtn:
            break
        case cbtn:
            break
        case dbtn:
            break
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.zPosition = -1
        if isQuestionLoaded == nil  {
            setBorder(layer: questionLabel.layer)
            setBorder(layer: abtn.layer)
            setBorder(layer: bbtn.layer)
            setBorder(layer: cbtn.layer)
            setBorder(layer: dbtn.layer)
            setBorder(layer: backbtn.layer,width: 1,radius: 3)
            loadQuestion(id: 1)
        }
        
    }
    
    func setBorder(layer: CALayer,width: CGFloat = 2.5,color: CGColor = UIColor.white.cgColor,radius: CGFloat = 30){
        layer.borderWidth = width
        layer.borderColor = color
        layer.cornerRadius = radius
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadQuestion(id :Int){
        print("startload Question")
        let urlString = "http://sunado.me:3000/question/\(id)"
        guard let requestUrl = URL(string:urlString) else { return }
        
        let request = URLRequest(url:requestUrl)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil,let usableData = data {
                print("===============================")
                print(usableData) //JSONSerialization
                do {
                    let json = try JSONSerialization.jsonObject(with: usableData) as? [String:Any]
                    print("\(String(describing: json))")
                    let question = ChooseQuestion.create(data: json!)
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
                    
                } catch {
                    print(" some thing wrong")
                }
            }
        }
        task.resume()
        
    }
    
    func loadData(url: String,didwhenfinish: @escaping ([String:Any]?)->Void){
        guard let requestUrl = URL(string:url) else { return }
        
        let request = URLRequest(url:requestUrl)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil,let usableData = data {
                print(usableData) //JSONSerialization
                do {
                    let json = try JSONSerialization.jsonObject(with: usableData) as? [String:Any]
                    print("\(String(describing: json))")
                    didwhenfinish(json)
                } catch {
                    print(" some thing wrong")
                }
            }
        }
        task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
