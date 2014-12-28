//
//  WallSprite.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/23/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class WallSprite: SKSpriteNode {
  
  
  override init() {
    super.init()
    name = "wall"
    color = SKColor.brownColor()
    size = CGSizeMake(17, 335)
    position = CGPointMake(13,170)
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.dynamic = false
    physicsBody?.allowsRotation = false
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
