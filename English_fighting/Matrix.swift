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
    let maxRow:Int = Config.MapSize.row
    let unMoveAble : SKTexture = SKTexture(imageNamed: "mountain")
    let moveAble : SKTexture = SKTexture(imageNamed: "sea")
    
    //
    var matrix: [[Int]] = []
    let row: Int!
    let col: Int!
    let width: CGFloat!
    let height: CGFloat!
    let blockSize :CGSize!
    
    enum NodeType{
        case Sea
        case Mountain
        case Trap
        case Treasure
    }
    
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
                if (r == 0) && (c == col-1) {
                    let treasure = makeCell(r: r, c: c, type: .Treasure)
                    row.append(3)
                    scene.addChild(treasure)
                    continue
                }
                if rand(range: 7) {
                    let mountain = makeCell(r: r, c: c, type: .Mountain)
                    row.append(1)
                    scene.addChild(mountain)
                } else if rand(range: 10){
                    let trap = makeCell(r: r, c: c, type: .Trap)
                    row.append(2)
                    scene.addChild(trap)
                } else{
                    let sea = makeCell(r: r, c: c, type: .Sea)
                    row.append(0)
                    scene.addChild(sea)
                }
                
            }
            self.matrix.append(row)
        }
    }
    
    
    func makeCell(r:Int, c:Int, type:NodeType) ->SKSpriteNode{
        let block  = SKSpriteNode()
        let px = CGFloat(c) * blockSize.width - width/2 + blockSize.width/2
        let py = CGFloat(r) * blockSize.height - height/2 + blockSize.height/2
        block.size = blockSize
        block.position = CGPoint(x: px, y: py)
        block.name = "sea"
        
        switch type {
        case .Mountain:
            block.texture = self.unMoveAble
            block.name = "mountain"
            
            let mountainPhysic = SKPhysicsBody(rectangleOf: blockSize)
            mountainPhysic.isDynamic = false
            mountainPhysic.categoryBitMask = Config.Physic.mountainCategory
            mountainPhysic.contactTestBitMask = Config.Physic.shipCategory
            mountainPhysic.collisionBitMask = Config.Physic.all
            block.physicsBody = mountainPhysic
            break
        case .Trap:
            block.color = .blue
            block.name = "trap"
            
            let trapPhysic = SKPhysicsBody(rectangleOf: blockSize)
            trapPhysic.isDynamic = false
            trapPhysic.categoryBitMask = Config.Physic.trapCategory
            trapPhysic.contactTestBitMask = Config.Physic.shipCategory
            trapPhysic.collisionBitMask = Config.Physic.all
            block.physicsBody = trapPhysic
            break
        case .Treasure:
            block.color = .yellow
            block.name = "treasure"
            let treasurePhysic = SKPhysicsBody(rectangleOf: blockSize)
            treasurePhysic.isDynamic = false
            treasurePhysic.categoryBitMask = Config.Physic.trapCategory
            treasurePhysic.contactTestBitMask = Config.Physic.shipCategory
            treasurePhysic.collisionBitMask = Config.Physic.all
            block.physicsBody = treasurePhysic
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
