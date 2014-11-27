//
//  PlayerSprite.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/23/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class PlayerSprite: SKSpriteNode {
  
  override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
  }
  
  override init() {
    super.init()
    name = "player"
    color = SKColor.redColor()
    texture = SKTexture(imageNamed: "player")
    size = CGSizeMake(30, 50)
    physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
    physicsBody?.dynamic = true
    physicsBody?.affectedByGravity = true
    physicsBody?.allowsRotation = false 
    physicsBody?.categoryBitMask = Category.Player
    physicsBody?.restitution = 0
    physicsBody?.mass = 0.05
    physicsBody?.contactTestBitMask = Category.TargetPlatform | Category.Platform
    physicsBody?.collisionBitMask = Category.TargetPlatform   | Category.Platform
    physicsBody?.usesPreciseCollisionDetection = true

  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
}
