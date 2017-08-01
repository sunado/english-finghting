//
//  QuestionViewActionHelper.swift
//  English_fighting
//
//  Created by hnc on 7/31/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation
import UIKit
struct QuestionViewActionHelper {
    func comfirmEscape(delegate:AnswerDelegate,view: UIViewController){
        let alert : UIAlertController = UIAlertController(title: "",
                                                          message: "You want quit ?", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "YES", style: .default){  action in
            //do something
            delegate.send(result: false)
            
            view.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "NO",style: .default)
        alert.addAction(comfirmAction)
        alert.addAction(cancel)
        view.present(alert, animated: true, completion: nil)
    }
    
    func showRightAnswerAlert(delegate:AnswerDelegate,view: UIViewController){
        print("showRightAnswerAlert")
        let alert : UIAlertController = UIAlertController(title: "Great", message: "You win the fight", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "OK", style: .default){  action in
            delegate.send(result: true)
            view.navigationController?.popViewController(animated: true)
        }
        alert.addAction(comfirmAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    func showWrongAnswerAlert(delegate:AnswerDelegate,view: UIViewController){
        let alert : UIAlertController = UIAlertController(title: "Oh no", message: "You lose the fight", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "OK", style: .default){  action in
            delegate.send(result: false)
            view.navigationController?.popViewController(animated: true)
        }
        alert.addAction(comfirmAction)
        view.present(alert, animated: true, completion: nil)
    }
}
