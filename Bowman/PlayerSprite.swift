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
    color = SKColor.redColor()
    size = CGSizeMake(70, 150)

    physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
    physicsBody?.dynamic = true
    physicsBody?.affectedByGravity = true
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }

}
