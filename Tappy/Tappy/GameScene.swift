//  GameScene.swift
//  Tappy
//  Created by Jessica Alexander on 7/18/19.
//  Copyright © 2019 Jessica Alexander. All rights reserved.

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var plane = SKSpriteNode()
    var background = SKSpriteNode()
    var ground = SKSpriteNode()
    var movingObjects = SKNode()
    var labelHolder = SKSpriteNode()
    var score = 0
    var gameLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var startLabel = SKLabelNode()
    var gameOver = false
    var contactQueue = [SKPhysicsContact]()
    let planeGroup:UInt32 = 1 << 0
    let objectGroup:UInt32 = 1 << 1
    let gapGroup:UInt32 = 1 << 2
    
    func makeBackground(){
        let backgroundImage = SKTexture(imageNamed: "bg")
        let moveBackground = SKAction.moveBy(x: -backgroundImage.size().width, y: 0, duration: 9)
        let replaceBackground = SKAction.moveBy(x: backgroundImage.size().width, y: 0, duration: 0)
        let moveBackgroundForever = SKAction.repeatForever(SKAction.sequence([moveBackground, replaceBackground]))
        
        for x in 0..<3{
            let i = CGFloat(x)
            background = SKSpriteNode(texture: backgroundImage)
            background.name = "bg"
            background.position = CGPoint(x: backgroundImage.size().width * i, y: -self.frame.midY)
            background.size.height = self.frame.height
            background.run(moveBackgroundForever)
            background.zPosition = -1
            movingObjects.addChild(background)
        }
    }
    
    
    func makePlane() {
        let planeImage = SKTexture(imageNamed: "planeYellow1")
        let planeImage2 = SKTexture(imageNamed: "planeYellow2")
        let planeImage3 = SKTexture(imageNamed: "planeYellow3")
        let animation = SKAction.animate(with: [planeImage, planeImage2, planeImage3], timePerFrame: 0.1)
        let makePlaneFly = SKAction.repeatForever(animation)
        
        plane = SKSpriteNode(texture: planeImage)
        plane.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        plane.run(makePlaneFly)
        
        plane.physicsBody = SKPhysicsBody(texture: plane.texture!, size: plane.texture!.size())
        plane.physicsBody?.isDynamic = true
        plane.physicsBody?.allowsRotation = false
        plane.physicsBody?.affectedByGravity = false
        plane.physicsBody?.categoryBitMask = planeGroup
        plane.physicsBody?.collisionBitMask = objectGroup
        plane.physicsBody?.contactTestBitMask = gapGroup | objectGroup
        plane.zPosition = 10 
        
        self.addChild(plane)
    }
    
    @objc func makePipes() {
        if(gameOver == false ){
            let pipe1Image = SKTexture(imageNamed: "pipe1")
            let pipe1 = SKSpriteNode(texture: pipe1Image)
            let pipe2Image = SKTexture(imageNamed: "pipe1")
            let pipe2 = SKSpriteNode(texture: pipe2Image)
            let coinImage = SKTexture(imageNamed: "medalGold")
            let gapCoin = SKSpriteNode(texture: coinImage)
            let gapHeight = plane.size.height
            let pipe1Offset = arc4random() % UInt32(self.frame.size.height / 4)
            let pipe2Offset = arc4random() % UInt32(self.frame.size.height / 4)
            let addPipes = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: TimeInterval(self.frame.size.width / 100))
            let removePipes = SKAction.removeFromParent()
            let movePipes = SKAction.sequence([addPipes, removePipes])
            
            pipe1.position = CGPoint(x: self.frame.midX + self.frame.size.width, y: self.frame.midY + pipe1Image.size().height / 2 + gapHeight / 2 + CGFloat(pipe1Offset))
            pipe1.run(movePipes)
            pipe1.physicsBody = SKPhysicsBody(rectangleOf: pipe1.size)
            pipe1.physicsBody?.isDynamic = false
            pipe1.physicsBody?.categoryBitMask = objectGroup
            pipe1.zPosition = 1
            movingObjects.addChild(pipe1)
            
            pipe2.position = CGPoint(x: self.frame.midX + self.frame.size.width, y: self.frame.midY - pipe2Image.size().height / 2 - gapHeight / 2 - CGFloat(pipe2Offset))
            pipe2.run(movePipes)
            pipe2.physicsBody = SKPhysicsBody(rectangleOf: pipe1.size)
            pipe2.physicsBody?.isDynamic = false
            pipe2.physicsBody?.categoryBitMask = objectGroup
            pipe2.zPosition = 1
            movingObjects.addChild(pipe2)
            
            
            gapCoin.position = CGPoint(x: self.frame.midX + self.frame.size.width, y: self.frame.midY + CGFloat(pipe1Offset) - CGFloat(pipe2Offset))
            gapCoin.physicsBody = SKPhysicsBody(rectangleOf: gapCoin.size)
            gapCoin.run(movePipes)
            gapCoin.physicsBody?.isDynamic = false
            gapCoin.physicsBody?.categoryBitMask = gapGroup
            movingObjects.addChild(gapCoin)
        }
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        self.addChild(movingObjects)
        movingObjects.isPaused = true
        movingObjects.speed = 0
        makeBackground()
        
        let ground = SKNode()
        ground.position = CGPoint(x: 0, y: -self.frame.height/2 + 1)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: 1))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = objectGroup
        self.addChild(ground)
        
        self.addChild(labelHolder)
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height/3)
        scoreLabel.zPosition = 9
        self.addChild(scoreLabel)
        
        startLabel.fontName = "Helvetica"
        startLabel.fontSize = 30
        startLabel.text = "Tap to Play"
        startLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        startLabel.zPosition = 11
        self.addChild(startLabel)
        
        makePlane()
        
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(GameScene.makePipes), userInfo: nil, repeats: true)
        
        physicsWorld.contactDelegate = self
        }
    
    func didBegin(_ contact: SKPhysicsContact) {
        contactQueue.append(contact)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(gameOver == false){
            startLabel.removeFromParent()
            plane.physicsBody?.affectedByGravity = true
            plane.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
            plane.physicsBody?.applyImpulse(CGVector(dx: 0,dy: 30))
            movingObjects.isPaused = false
            movingObjects.speed = 1
        }else{
            score = 0
            scoreLabel.text = "0"
            movingObjects.removeAllChildren()
            makeBackground()
            plane.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            labelHolder.removeAllChildren()
            plane.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            gameOver = false
            movingObjects.speed = 1
            
        }
}


    func handle(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil {
            return
        }
        
        if (contact.bodyA.categoryBitMask == gapGroup || contact.bodyB.categoryBitMask == gapGroup){
            score += 1
            scoreLabel.text = "\(score)"
            if contact.bodyA.categoryBitMask == gapGroup {
                contact.bodyA.node!.removeFromParent()
            } else {
                contact.bodyB.node!.removeFromParent()
            }
        } else {
            if gameOver == false{
                gameOver = true
                movingObjects.speed = 0
                gameLabel.fontName = "Helvetica"
                gameLabel.fontSize = 30
                gameLabel.text = "Game Over! Tap to play again."
                gameLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                gameLabel.zPosition = 10
                labelHolder.addChild(gameLabel)
            }
        }
    }
    
    func processContacts(forUpdate currenTime: CFTimeInterval) {
        for contact in contactQueue {
            handle(contact)
            if let index = contactQueue.firstIndex(of: contact) {
                contactQueue.remove(at: index)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        processContacts(forUpdate: currentTime)
    }
    
}

