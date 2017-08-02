//
//  User.swift
//  English_fighting
//
//  Created by hnc on 7/26/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation

struct User {
    
   var facebookId:  String
   var charracter:  String
   var fullname: String
   var birth_date: Date
   var email: String
   var phone: String
   var level: Int
   var rank: Int
   var total_win_games: Int
   var total_games: Int
   var total_questions: Int
   var total_right_questions: Int
   
   
    static func getUser(data: [String:Any]) ->User?{
        guard let facebookId:String = data["facebookId"] as? String else{
            print("User getUser cannot user facebookId")
            return nil
        }
        guard let charracter:String = data["charracter"] as? String else{
            print("User getUser cannot user charracter")
            return nil
        }
        guard let fullname:String = data["fullname"] as? String else{
            print("User getUser cannot user fullname")
            return nil
        }
        guard let email:String = data["email"] as? String else{
            print("User getUser cannot user email")
            return nil
        }
        guard let phone:String = data["phone"] as? String else{
            print("User getUser cannot user phone")
            return nil
        }
        guard let level:Int = data["level"] as? Int else{
            print("User getUser cannot user level")
            return nil
        }
        guard let rank:Int = data["rank"] as? Int else{
            print("User getUser cannot user rank")
            return nil
        }
        guard let total_win_games:Int = data["total_win_games"] as? Int else{
            print("User getUser cannot user total_win_games")
            return nil
        }
        guard let total_games:Int = data["total_games"] as? Int else{
            print("User getUser cannot user total_games")
            return nil
        }
        guard let total_questions:Int = data["total_questions"] as? Int else{
            print("User getUser cannot user total_questions")
            return nil
        }
        guard let total_right_questions:Int = data["total_right_questions"] as? Int else{
            print("User getUser cannot user total_right_questions")
            return nil
        }
        guard let birth_date:Date = data["birth_date"] as? Date else{
            print("User getUser cannot user birth_date")
            return nil
        }
        
        return User(facebookId: facebookId, charracter: charracter, fullname: fullname, birth_date: birth_date, email: email, phone: phone, level: level, rank: rank, total_win_games: total_win_games, total_games: total_games, total_questions: total_questions, total_right_questions: total_right_questions)
    }
    
    func toAnyObject() ->Any {
        return [
            "facebookId": facebookId,
            "charracter": charracter,
            "fullname": fullname,
            "birth_date": birth_date,
            "email": email,
            "phone": phone,
            "level": level,
            "rank": rank,
            "total_win_games": total_win_games,
            "total_games": total_games,
            "total_questions": total_questions,
            "total_right_question": total_right_questions
        ]
    }
}
