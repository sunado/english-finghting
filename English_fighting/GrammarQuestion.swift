//
//  GrammarQuestion.swift
//  English_fighting
//
//  Created by sunado on 8/3/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation

struct GrammarQuestion {
    let key: String
    let wrongSentence: [String]
    let baseSentence: [String]
    let wrongPos: [Int]
    
    init(wrongSentence: String,baseSentence: String,wrongPos: [Int],key: String = ""){
        self.key = key
        self.wrongSentence = wrongSentence.components(separatedBy: " ")
        self.baseSentence = baseSentence.components(separatedBy: " ")
        self.wrongPos = wrongPos
    }
    
    static func create(data: [String:Any]) ->GrammarQuestion?{
        guard let baseSentence = data["baseSentence"] as? String,
              let wrongSentence = data["wrongSentence"] as? String,
              let wrongPos = data["wrongPos"] as? [Int]
        else {
            print("Data recieve corupt")
            return nil
        }
        return GrammarQuestion(wrongSentence: wrongSentence, baseSentence: baseSentence, wrongPos: wrongPos)
    }
    
    func toAnyObject() -> Any {
        return [
            "wrongSentence": wrongSentence,
            "baseSentence": baseSentence,
            "wrongPos": wrongPos
        ]
    }
}
