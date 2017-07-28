//
//  Config.swift
//  English_fighting
//
//  Created by hnc on 7/27/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation
import SpriteKit
struct Config{
    
    struct Physic{
        //collision bit mask
        public static let shipCategory: UInt32 = 0x1 << 0
        public static let trapCategory: UInt32 = 0x1 << 1
        public static let shipCollisionBitMask: UInt32 = 0x1 << 2
        public static let mountainCollisionBitMask: UInt32 = 0x1 << 2
        public static let mountainCategory: UInt32 = 0x1 << 2
        public static let all: UInt32 = 0
    }
    struct MapSize{
        
        public static let row: Int = 15
   
    }
    struct Dice{
        public static func getTexture() -> [SKTexture] {
            let diceImages: [String] = ["Dice1","Dice2","Dice3","Dice4","Dice5","Dice6"]
            var runFrames: [SKTexture] = []
            for i in diceImages {
                let texture = SKTexture(imageNamed: i)
                runFrames.append(texture)
            }
            return runFrames
        }
    }
}
