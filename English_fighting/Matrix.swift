//
//  Matrix.swift
//  English_fighting
//
//  Created by hnc on 7/18/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import Foundation
import SpriteKit



class Matrix{
    var matrix: [[SKSpriteNode]] = []
    
    let unMoveAble : SKTexture = SKTexture(imageNamed: "mountain")
    let moveAble : SKTexture = SKTexture(imageNamed: "sea")
    
    let row: Int!
    let col: Int!
    let width: CGFloat!
    let height: CGFloat!
    
    init(){
        row = 10
        col = 15
        width = 1000
        height = 800
    }
    
    init(w: CGFloat,h : CGFloat){
        row = 15
        col =  Int(CGFloat(row) * h/w)
        width = w
        height = h
        print("row: \(row) col: \(col) width: \(w) height \(h)")
    }

    func makeBoard(scene: SKScene, shipCategory: UInt32,trapCategory: UInt32){
        let blockSizeX:CGFloat = width / CGFloat(row)
        let blockSizeY:CGFloat = height / CGFloat(col)
        var id:Int = 0
        let size : CGSize = CGSize(width: blockSizeX, height: blockSizeY)
        
        
        for r in 0..<row {
            var row : [SKSpriteNode] = []
            for c in 0..<col{
                let block  = SKSpriteNode()
                block.size = size
                block.position = CGPoint(x: CGFloat(r) * blockSizeX - width/2+1, y:  CGFloat(c) * blockSizeY - height/2+1)
                block.name = "sea-\(id)"
                block.texture = moveAble
                
                id += 1
                if rand(range: 7) {
                    block.texture = self.unMoveAble
                    block.name = "mountain-\(id)"
                    
                    let mountainPhysic = SKPhysicsBody(rectangleOf: size)
                    mountainPhysic.isDynamic = false
                    mountainPhysic.categoryBitMask = 0x1 << 2
                    mountainPhysic.contactTestBitMask = shipCategory
                    mountainPhysic.collisionBitMask = 0
                    //mountainPhysic.usesPreciseCollisionDetection = true

                    block.physicsBody = mountainPhysic
                } else if rand(range: 10){
                    block.texture = nil
                    block.color = .purple
                    block.name = "trap-\(id)"
                    
                    let trapPhysic = SKPhysicsBody(rectangleOf: size)
                    trapPhysic.isDynamic = false
                    trapPhysic.categoryBitMask = trapCategory
                    trapPhysic.contactTestBitMask = shipCategory
                    trapPhysic.collisionBitMask = 0
                    
                    block.physicsBody = trapPhysic
                }
                row.append(block)
                scene.addChild(block)
            }
            self.matrix.append(row)
        }
    }

    func rand(range: Int) -> Bool{
        let num: Int  = Int(arc4random_uniform(UInt32(range)))
        return num == 0 ? true : false
    }
}
