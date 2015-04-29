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
  
   init() {
    var color = SKColor.brownColor()
    var size = CGSizeMake(100, 15)
    super.init(texture: nil, color: color, size: size)
    name = "ledge"
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
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(location : CGPoint, size: CGSize = CGSizeMake(100, 15)) {
    self.init()
    name = "ledge"
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
