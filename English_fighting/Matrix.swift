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
    //
    let maxRow: Int = 20
    let unMoveAble : SKTexture = SKTexture(imageNamed: "mountain")
    let moveAble : SKTexture = SKTexture(imageNamed: "sea")
    let shipCategory:UInt32 = 0x1 << 0
    let trapCategory:UInt32 = 0x1 << 1
    let mountainCollsion: UInt32 = 0x1 << 2
    
    //
    var matrix: [[Int]] = []
    let row: Int!
    let col: Int!
    let width: CGFloat!
    let height: CGFloat!
    let blockSize :CGSize!
    
    init(){
        row = 10
        col = 15
        width = 1000
        height = 800
        let blockSizeX:CGFloat = width / CGFloat(col)
        let blockSizeY:CGFloat = height / CGFloat(row)
        blockSize = CGSize(width: blockSizeX, height: blockSizeY)
    }
    
    init(w: CGFloat,h : CGFloat){
        row = maxRow
        col =  Int(CGFloat(row) * w/h)
        width = w
        height = h
        let blockSizeX:CGFloat = width / CGFloat(col)
        let blockSizeY:CGFloat = height / CGFloat(row)
        blockSize = CGSize(width: blockSizeX, height: blockSizeY)
        print("row: \(row) col: \(col) width: \(w) height \(h)")
    }

    func makeBoard(scene: SKScene){
        for r in 0..<row {
            var row : [Int] = []
            for c in 0..<col{
                if rand(range: 7) {
                    let mountain = makeCell(r: r, c: c, bit: 1)
                    row.append(1)
                    scene.addChild(mountain)
                } else if rand(range: 10){
                    let trap = makeCell(r: r, c: c, bit: 2)
                    row.append(2)
                    scene.addChild(trap)
                } else{
                    let sea = makeCell(r: r, c: c, bit: 3)
                    row.append(0)
                    scene.addChild(sea)
                }
            }
            self.matrix.append(row)
        }
    }
    
    
    func makeCell(r:Int, c:Int, bit:Int) ->SKSpriteNode{
        let block  = SKSpriteNode()
        let px = CGFloat(c) * blockSize.width - width/2 + blockSize.width/2
        let py = CGFloat(r) * blockSize.height - height/2 + blockSize.height/2
        block.size = blockSize
        block.position = CGPoint(x: px, y: py)
        block.name = "sea"
        block.texture = moveAble
        switch bit {
        case 1:
            block.texture = self.unMoveAble
            block.name = "mountain"
            
            let mountainPhysic = SKPhysicsBody(rectangleOf: blockSize)
            mountainPhysic.isDynamic = false
            mountainPhysic.categoryBitMask = mountainCollsion
            mountainPhysic.contactTestBitMask = shipCategory
            mountainPhysic.collisionBitMask = 0
            block.physicsBody = mountainPhysic
            break
        case 2:
            block.texture = nil
            block.color = .purple
            block.name = "trap"
            
            let trapPhysic = SKPhysicsBody(rectangleOf: blockSize)
            trapPhysic.isDynamic = false
            trapPhysic.categoryBitMask = trapCategory
            trapPhysic.contactTestBitMask = shipCategory
            trapPhysic.collisionBitMask = 0
            block.physicsBody = trapPhysic
            break
        default :
            block.name = "sea"
            block.texture = moveAble
            break
        }
        return block
    }

    func rand(range: Int) -> Bool{
        let num: Int  = Int(arc4random_uniform(UInt32(range)))
        return num == 0 ? true : false
    }
}
