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
    
    @IBOutlet weak var avataView: UIImageView!
    
    @IBAction func loginPerform(_ sender: UIButton) {
        if((FBSDKAccessToken.current()) == nil || FBSDKAccessToken.current().expirationDate < Date() ){
            login()
        } else {
            self.loadUserdata(token: FBSDKAccessToken.current().tokenString)
        }
        
    }
    let loginManager: FBSDKLoginManager = FBSDKLoginManager()
    let readPermissions = ["public_profile","email","user_friends"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func login(){
        loginManager.logIn(withReadPermissions: readPermissions, from: self){ (res,err) in
            if(err == nil){
                if(err == nil){
                    print("login success accesstoken is: \(FBSDKAccessToken.current().tokenString)")
                    if let result = res {
                        if result.grantedPermissions != nil {
                            //self.getData()
                            self.loadUserdata(token: FBSDKAccessToken.current().tokenString)
                        }
                    }
                }else{
                    print("login fail")
                }
            }
        }
    }
    
    func getData(){
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name"])
                .start(completionHandler: { (connect,result,err) in
                    if err == nil {
                        let dict = result as! Dictionary<String,Any>
                        print(dict)
                    }
                    
                })
        }
    }
    func loadUserdata(token: String){
        print("startload data")
        let urlString = "http://localhost:3000/auth/token=\(token)"
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
                } catch {
                    print(" some thing wrong")
                }
            }
        }
        task.resume()
    }
    
}
