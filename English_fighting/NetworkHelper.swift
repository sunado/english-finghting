//
//  NetworkHelper.swift
//  English_fighting
//
//  Created by hnc on 7/31/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
struct NetWorkHelper {
    let readPermissions = ["public_profile","email","user_friends"]
    
    static let host = "sunado.me:3000"
    
    static var isLogin: Bool {
        get{
            return FBSDKAccessToken.current() != nil && FBSDKAccessToken.current().expirationDate > Date()
        }
    }
    
    func loadQuestion(id :Int,type: String,completeHandler: @escaping (_ json: [String:Any]) -> Void){
        print("startload Question")
        let urlString = "http://\(NetWorkHelper.host)/question/\(type)/\(id)"
        print("url: \(urlString)")
        guard let requestUrl = URL(string:urlString) else { return }
        let request = URLRequest(url:requestUrl)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil,let usableData = data {
                //print("===============================")
                print(usableData) //JSONSerialization
                do {
                    let json = try JSONSerialization.jsonObject(with: usableData) as? [String:Any]
                    print("\(String(describing: json))")
                    
                    completeHandler(json!)
                } catch {
                    print(" some thing wrong")
                }
            }
        }
        task.resume()
    }
    
    func login(viewController: UIViewController){
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: readPermissions, from: viewController){ (res,err) in
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
    
    func loadUserdata(token: String){
        print("startload data")
        let urlString = "http://\(NetWorkHelper.host)/auth/token=\(token)"
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
    
    func loadAvata(completeHandler: @escaping (_ image : UIImage?) ->Void) {
        if NetWorkHelper.isLogin == true {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"picture"])
                .start(completionHandler: { (connect,result,err) in
                    if err == nil , let result = result{
                        let dict =  result as! Dictionary<String,Any>
                        print(dict)
                        let picture =  dict["picture"] as! [String:Any]
                        print(picture)
                        let data =   picture["data"] as! [String:Any]
                        print(data)
                        if let imageUrl = data["url"] as? String {
                            print(imageUrl)
                            URLSession.shared.dataTask(with: NSURL(string: imageUrl)! as URL,
                                        completionHandler: { (data, response, error) -> Void in
                                if error != nil {
                                    print(error ?? "error ")
                                    return
                                }
                                let image = UIImage(data: data!)
                                completeHandler(image)
                                
                            }).resume()
                        }
                    }
                })
        }
        
    }
    
    func getData(){
        if NetWorkHelper.isLogin == true {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name"])
                .start(completionHandler: { (connect,result,err) in
                    if err == nil {
                        let dict = result as! Dictionary<String,Any>
                        print(dict)
                    }
                    
                })
        }
    }
    func downloadFile(from url: URL,completeTask: @escaping (_ fileUrl: URL) -> Void){
        let downloadTask: URLSessionDownloadTask
          = URLSession.shared.downloadTask(with: url){
            (url,respond,err) in
            if err == nil, let url = url {
                completeTask(url)
            }
        }
        downloadTask.resume()
    }
}
