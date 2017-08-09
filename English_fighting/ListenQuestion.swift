//
//  ListenQuestion.swift
//  English_fighting
//
//  Created by hnc on 7/31/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation
struct ListenQuestion {
    let key: String
    let question: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let audioPath: String
    let answer: Int
    init(question: String,A: String,B: String,C: String,D: String,audioPath: String,answer: Int, key: String = ""){
        self.question = question
        self.answerA = A
        self.answerB = B
        self.answerC = C
        self.answerD = D
        self.audioPath = audioPath
        self.key = key
        self.answer = answer
    }
    
    static func create(data: [String:Any])->ListenQuestion?{
        guard let question:String = data["question"] as? String,
            let a:String = data["a"] as? String, let b:String = data["b"] as? String,
            let c:String = data["c"] as? String, let d:String = data["d"] as? String,
            let audioPath = data["audio"] as? String, let answer = data["answer"] as? Int
            else {
                print("data has no question")
                return nil
        }
        return ListenQuestion(question: question, A: a, B: b, C: c, D: d,audioPath: audioPath, answer: answer)
    }
    
    func toAnyObject() ->Any {
        return [
            "question":question,
            "a":answerA,
            "b":answerB,
            "c":answerC,
            "d":answerD,
            "audio": audioPath
        ]
    }

}
