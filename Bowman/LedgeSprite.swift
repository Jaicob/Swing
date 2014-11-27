//
//  LedgeSprite.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/25/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class LedgeSprite: SKSpriteNode {
  let startPosition = CGPointMake(70,522)
  
  override init() {
    super.init()
    name = "ledge"
    color = SKColor.brownColor()
    size = CGSizeMake(100, 25)
    position = startPosition
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.dynamic = false
    physicsBody?.allowsRotation = false
    physicsBody?.pinned = false
    physicsBody?.restitution = 0
    physicsBody?.categoryBitMask = Category.Platform
    physicsBody?.contactTestBitMask = Category.Player
    physicsBody?.collisionBitMask = Category.Player
    physicsBody?.usesPreciseCollisionDetection = false

  }
  
  override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(location : CGPoint, size: CGSize = CGSizeMake(100, 25)) {
    super.init()
    name = "ledge"
    color = SKColor.brownColor()
    self.size = size
    position = location
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.dynamic = false
    physicsBody?.allowsRotation = false
    physicsBody?.pinned = false
    physicsBody?.restitution = 0
    physicsBody?.categoryBitMask = Category.TargetPlatform
    physicsBody?.contactTestBitMask = Category.Player
    physicsBody?.collisionBitMask = Category.Player
    physicsBody?.usesPreciseCollisionDetection = false
  }
  
}
