//
//  GameScene.swift
//  English_fighting
//
//  Created by hnc on 7/18/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import SpriteKit
import GameplayKit
import SceneKit
class GameScene: SKScene {
    //tau
    var ship: SKSpriteNode!
    //vi tri cuoi
    var lastPosstion: CGPoint!
    //ban do
    var boards :Matrix!
    //dice
    var dice: SKSpriteNode!
    var diceFrame: [SKTexture]!
    //state
    enum State{
        case BEGINTURN
        case STARTROLL
        case ENDROLL
        case MOVEABLE
        case ENDMOVE
        case MEETPIVATE
        case ANSWERED
        case ENDTURN
        case FINISH
        case ROLLBACK
    }
    var state: State!
    //khoi tao cac node
    override func didMove(to view: SKView) {
        print("init node")
        initBoard()
        initShip()
        initDice()
        state = State.BEGINTURN
        physicsWorld.contactDelegate = self
    }
    //click event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //print("show click event")
            let location = t.location(in: self)
            print(" =============================== Touch: \(location.x)  \(location.y) ")
            
            switch state! {
            case .BEGINTURN:
                print("state ")
                rolltheDice()
                break
            case .STARTROLL:
                break
            case .ENDROLL:
                lastPosstion = ship.position
                state = State.MOVEABLE
                let action = SKAction.move(to: location, duration: 2.5)
                ship.run(action)
                break
            case .ENDMOVE:
                break
            case .MOVEABLE:
                let action = SKAction.move(to: location, duration: 2.5)
                ship.run(action)
                break
            default:
                break
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene {
    func initShip(){
        print("ship")
        ship = SKSpriteNode(imageNamed: "ship.png")
        ship.position = CGPoint(x: -200, y: -200)
        ship.zPosition = 1
        ship.size = CGSize(width: 40, height: 40)
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.size)
        ship.physicsBody?.isDynamic = true
        ship.physicsBody?.affectedByGravity = false
        ship.physicsBody?.categoryBitMask = Config.Physic.shipCategory
        ship.physicsBody?.contactTestBitMask = Config.Physic.trapCategory
        ship.physicsBody?.collisionBitMask = Config.Physic.shipCollisionBitMask
        lastPosstion = ship.position
        self.addChild(ship)
    }
    
    func initBoard(){
        print("boards")
        boards = Matrix(w: self.size.width, h: self.size.height)
        boards.makeBoard(scene: self)
    }
    
    func initDice(){
        diceFrame = []
        let diceImages: [String] = ["Dice1","Dice2","Dice3","Dice4","Dice5","Dice6"]
        for i in diceImages {
            let texture = SKTexture(imageNamed: i)
            diceFrame.append(texture)
        }
        dice = SKSpriteNode(texture: diceFrame[0])
        dice.position = CGPoint(x: 0, y: 0)
        dice.size = CGSize(width: 150, height: 150)
        dice.zPosition = 1
        dice.isHidden = true
        self.addChild(dice)
    }
    
    func rolltheDice(){
        self.dice.isHidden = false
        let roll = SKAction.repeat(SKAction.animate(with: diceFrame, timePerFrame: 0.06), count: 5)
        self.state = State.STARTROLL
        dice.run(roll){
            let diceNumber = Int(arc4random_uniform(UInt32(6)))
            self.dice.texture = self.diceFrame[diceNumber]
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                self.dice.isHidden = true
                self.state = State.ENDROLL
            }
        }
    }
    
    func showMeetPivateAlert(){
        let alert : UIAlertController = UIAlertController(title: "Meet Private",
            message: "You had meet private, fight for life ?", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "YES", style: .default){ [unowned self ] action in
            //do something
            self.loadQuestion()
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
        let action = SKAction.move(to: lastPosstion, duration: 1.5)
        self.ship.physicsBody?.isDynamic = false
        state = State.ROLLBACK
        ship.run(action) {
            self.ship.physicsBody?.isDynamic = true
            self.state = State.BEGINTURN
        }
    }
    func loadQuestion(){
        let questionView  = ChooseQuestionController(nibName: "ChooseQuestionController", bundle: nil)
        questionView.answerDelegate = self
        let currentnavigation = UIApplication.shared.keyWindow!.rootViewController as! UINavigationController
        currentnavigation.pushViewController(questionView, animated: true)
    }
    func endGame(){
        let alert : UIAlertController = UIAlertController(title: "YOU WIN",
                                                          message: "DO YOU WANT TO REVIEW ANSWERS ?", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "YES", style: .default){ [unowned self ] action in
            //do something
            self.loadQuestion()
        }
        let cancel = UIAlertAction(title: "NO",style: .default){  action in
            //do something
            let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
            navigationController.popViewController(animated: true)
        }
        
        alert.addAction(comfirmAction)
        alert.addAction(cancel)
        
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    //kiem tra va cham
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nameA = contact.bodyA.node?.name else {
            print("contact A has no name")
            return
        }
        
        if state != State.ROLLBACK && nameA.hasPrefix("trap")  {
            self.ship.removeAllActions()
            self.showMeetPivateAlert()
        } else if nameA.hasPrefix("mountain") {
            self.ship.removeAllActions()
        } else if nameA.hasPrefix("treasure"){
            self.state = State.FINISH
            self.endGame()
        }
    }
}

extension GameScene: AnswerDelegate {
    func send(result: Bool){
        if result == false {
            self.rollbackPosition()
        }
    }
}
