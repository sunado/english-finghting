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
    public static let GRAMMARQUESTION = "grammar"
    public static let CHOOSEQUESTION_MAX:Int = 3200
    public static let LISTENQUESTION_MAX:Int = 3200
    public static let SPEAKQUESTION_MAX:Int = 3200
    public static let GRAMMARQUESTION_MAX:Int = 20
    public static func randQuestion(type: String) -> Int{
        switch type {
        case CHOOSEQUESTION:
            return Int(arc4random_uniform(UInt32(CHOOSEQUESTION_MAX)))
        case LISTENQUESTION:
            return Int(arc4random_uniform(UInt32(LISTENQUESTION_MAX)))
        case SPEAKQUESTION:
            return Int(arc4random_uniform(UInt32(SPEAKQUESTION_MAX)))
        case GRAMMARQUESTION:
            return Int(arc4random_uniform(UInt32(GRAMMARQUESTION_MAX)))
        default:
            return 1
        }
    }
}
