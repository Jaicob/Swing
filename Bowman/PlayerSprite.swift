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
    
    var color = SKColor.lightGrayColor()
    var size = CGSizeMake(30, 50)
    super.init(texture: nil, color: color, size: size)
    name = "player"
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
