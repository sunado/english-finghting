//
//  MainController.swift
//  English_fighting
//
//  Created by hnc on 7/24/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
class MainController: UIViewController {
    @IBOutlet weak var avataImageView: UIImageView!
    let netWorkHelper = NetWorkHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
        if(avataImageView.image == nil){
            netWorkHelper.loadAvata(){ image in
                DispatchQueue.main.async {
                    self.avataImageView.image = image
                }
            }
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func performPlay(_ sender: UIButton) {
        if(DataManager.isLogin()){
            let gameViewController = GameViewController(nibName: "GameViewController", bundle: nil)
            self.navigationController?.pushViewController(gameViewController, animated: true)
        }else {
            showToast(message: "You must login first")
        }
    }
    @IBAction func performLogin(_ sender: UIButton) {
        if DataManager.isLogin() {
            netWorkHelper.loadUserdata(token: FBSDKAccessToken.current().tokenString)
        } else {
            netWorkHelper.login(viewController: self){
                self.netWorkHelper.loadAvata(){ image in
                    DispatchQueue.main.async {
                        self.avataImageView.image = image
                    }
                }

            }
            
        }
    }
}
