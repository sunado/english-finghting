//
//  GameScene.swift
//  English_fighting
//
//  Created by hnc on 7/18/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    //tau
    var ship : SKSpriteNode!
    //vi tri cuoi
    var lastPosstion: CGPoint!
    var isRollBack: Bool!
    //ban do
    var boards :Matrix!
    //bit kiem tra va cham
    let shipCategory:UInt32 = 0x1 << 0
    let mapECategory:UInt32 = 0x1 << 1
    //khoi tao cac node
    override func didMove(to view: SKView) {
        print("init node")
        print("boards")
        boards = Matrix(w: self.size.width, h: self.size.height)
        boards.makeBoard(scene: self, shipCategory: shipCategory, trapCategory: mapECategory)
        
        print("ship")
        ship = SKSpriteNode(imageNamed: "ship.png")
        ship.position = CGPoint(x: -200, y: -200)
        ship.zPosition = 1
        ship.size = CGSize(width: 30, height: 30)
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.size)
        ship.physicsBody?.isDynamic = true
        ship.physicsBody?.affectedByGravity = false
        ship.physicsBody?.categoryBitMask = shipCategory
        ship.physicsBody?.contactTestBitMask = mapECategory
        ship.physicsBody?.collisionBitMask = 0x1 << 2
        
        lastPosstion = ship.position
        isRollBack = false
        self.addChild(ship)
        
        physicsWorld.contactDelegate = self
    }
    //kiem tra va cham
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact")
        
        guard let nameA = contact.bodyA.node?.name else {
            print("contact A has no name")
            return
        }
        

        if !isRollBack && nameA.hasPrefix("trap")  {
            showAlert()
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //print("show click event")
            let location = t.location(in: self)
            //print("Touch: \(location.x)  \(location.y) Node: \(touchnode)")
            let action = SKAction.move(to: location, duration: 3.0)
            
            lastPosstion = ship.position
            ship.run(action)
            
            self.touchDown(atPoint: t.location(in: self))
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func showAlert(){
        let alert : UIAlertController = UIAlertController(title: "Meet Private",
                message: "You had meet private, fight for life ?", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "YES", style: .default){ [unowned self ] action in
            //do something
        }
        let cancel = UIAlertAction(title: "NO",style: .default){ [unowned self] action in
            //do something
            self.rollbackPosition()
        }
        
        alert.addAction(comfirmAction)
        alert.addAction(cancel)
        
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    func rollbackPosition() {
        let action = SKAction.move(to: lastPosstion, duration: 2.5)
        isRollBack = true
        ship.run(action) {
            self.isRollBack = false
        }
    }
}
