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
    private var overlay : UIAlertController?
    
    func comfirmEscape(delegate:AnswerDelegate,view: UIViewController) {
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
    
    func showRightAnswerAlert(delegate:AnswerDelegate,view: UIViewController) {
        print("showRightAnswerAlert")
        let alert : UIAlertController = UIAlertController(title: "Great", message: "You win the fight", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "OK", style: .default){  action in
            delegate.send(result: true)
            view.navigationController?.popViewController(animated: true)
        }
        alert.addAction(comfirmAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    func showWrongAnswerAlert(delegate:AnswerDelegate,view: UIViewController) {
        let alert : UIAlertController = UIAlertController(title: "Oh no", message: "You lose the fight", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "OK", style: .default){  action in
            delegate.send(result: false)
            view.navigationController?.popViewController(animated: true)
        }
        alert.addAction(comfirmAction)
        view.present(alert, animated: true, completion: nil)
    }
    mutating func showLoadingOverlay(view: UIViewController) {
        if overlay == nil{
            overlay = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            
            overlay?.view.addSubview(loadingIndicator)
        }
        print("show overlay")
        overlay?.dismiss(animated: true, completion: nil)
        view.present(overlay!, animated: true, completion: nil)
    }
    func hideLoadingOverlay() {
        overlay?.dismiss(animated: true, completion: nil)
        print("hide overlay")
    }
}
