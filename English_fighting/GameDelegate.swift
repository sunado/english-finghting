//
//  GameDelegate.swift
//  English_fighting
//
//  Created by hnc on 7/27/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation


protocol AnswerDelegate{
    func send(result: Bool)
}

protocol GrammarAnswerDelegate{
    func send(result: Int)
}
