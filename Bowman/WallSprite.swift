//
//  WallSprite.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/23/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class WallSprite: SKSpriteNode {
  
  
   init() {
    var color = SKColor.brownColor()
    var size = CGSizeMake(17, 335)
    super.init(texture: nil, color: color, size: size)
    name = "wall"
    position = CGPointMake(13,170)
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.dynamic = false
    physicsBody?.allowsRotation = false

  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(location : CGPoint) {
    self.init()
//    color = SKColor.brownColor()
//    size = CGSizeMake(120, 30)
    position = location
  }
  
   
}
