//
//  SpeakQuestion.swift
//  English_fighting
//
//  Created by hnc on 8/1/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation
struct SpeakQuestion {
    let key: String
    let question: String
    let content: String
    
    
    init(question: String,content: String,key: String = ""){
        self.question = question
        self.content = content
        self.key = key
    }
    
    static func create(data: [String:Any])->SpeakQuestion?{
        guard let question:String = data["question"] as? String,
            let content:String = data["content"] as? String
            else {
                print("data has no question")
                return nil
        }
        return SpeakQuestion(question: question, content: content)
    }
    
    func toAnyObject() ->Any {
        return [
            "question":question,
            "content": content
        ]
    }
}
