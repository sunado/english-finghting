//
//  ExtendUiViewController.swift
//  English_fighting
//
//  Created by sunado on 8/2/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

class AbstractQuestionViewController: UIViewController{
    private var overlay : UIAlertController?
    var delegate: AnswerDelegate?
    var countDownTimer: Timer?
    private var progressView: UIProgressView?
    func comfirmEscape() {
        let alert : UIAlertController = UIAlertController(title: "",
                                                          message: "You want quit ?", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "YES", style: .default){  action in
            //do something
            self.delegate?.send(result: false)
            
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "NO",style: .default)
        alert.addAction(comfirmAction)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showRightAnswerAlert() {
        print("showRightAnswerAlert")
        let alert: UIAlertController = UIAlertController(title: "Great", message: "You win the fight", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "OK", style: .default){  action in
            self.delegate?.send(result: true)
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(comfirmAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showWrongAnswerAlert() {
        let alert: UIAlertController = UIAlertController(title: "Oh no", message: "You lose the fight", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "OK", style: .default){  action in
            self.delegate?.send(result: false)
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(comfirmAction)
        self.present(alert, animated: true, completion: nil)
    }
    func showLoadingOverlay() {
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
        self.present(overlay!, animated: true, completion: nil)
    }
    
    func hideLoadingOverlay() {
        overlay?.dismiss(animated: true, completion: nil)
        print("hide overlay")
    }
    
    func startCountDown(with progressView: UIProgressView){
        self.progressView = progressView
        countDownTimer = Timer.scheduledTimer(timeInterval: 1/20, target: self, selector: #selector(updateTimer),
                userInfo: nil, repeats: true)
    }
    @objc private func updateTimer(){
        if let progressView = progressView {
            let new = progressView.progress - 0.01/3
            if(new < 0){
                countDownTimer?.invalidate()
                showWrongAnswerAlert()
            }
            progressView.setProgress(new, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}
