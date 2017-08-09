//
//  ChooseQuestion.swift
//  English_fighting
//
//  Created by hnc on 7/24/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation

struct ChooseQuestion {
    let key: String
    let question: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let answer: Int
    
    init(question: String,A: String,B: String,C: String,D: String,answer: Int,key: String = ""){
        self.question = question
        self.answerA = A
        self.answerB = B
        self.answerC = C
        self.answerD = D
        self.answer = answer
        self.key = key
    }
    
    static func create(data: [String:Any])->ChooseQuestion?{
        guard let question:String = data["question"] as? String,
            let a: String = data["a"] as? String, let b: String = data["b"] as? String,
            let c: String = data["c"] as? String, let d: String = data["d"] as? String,
            let answer: Int = data["answer"] as? Int
            else {
                print("data has no question")
                return nil
        }
        return ChooseQuestion(question: question, A: a, B: b, C: c, D: d,answer: answer)
    }
    
    func toAnyObject() ->Any {
        return [
            "question":question,
            "a":answerA,
            "b":answerB,
            "c":answerC,
            "d":answerD,
            "answer":answer
        ]
    }
}
