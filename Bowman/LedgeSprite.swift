//
//  LedgeSprite.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/25/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class LedgeSprite: SKSpriteNode {

  override init() {
    super.init()
    name = "ledge"
    color = SKColor.brownColor()
    size = CGSizeMake(100, 17)
    position = CGPointMake(70,520)
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.dynamic = false
    physicsBody?.allowsRotation = false
    physicsBody?.pinned = false
  }
  
  override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(location : CGPoint) {
    super.init()
    color = SKColor.brownColor()
    size = CGSizeMake(120, 30)
    position = location
  }
  
}
