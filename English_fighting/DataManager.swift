//
//  DataManager.swift
//  English_fighting
//
//  Created by hnc on 7/31/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
struct DataManager {
    public static func isLogin() -> Bool {
        return FBSDKAccessToken.current() != nil
            && FBSDKAccessToken.current().expirationDate > Date()
    }
    public static let CHOOSEQUESTION = "choose"
    public static let LISTENQUESTION = "listen"
    public static let SPEAKQUESTION  = "speak"
    
}
