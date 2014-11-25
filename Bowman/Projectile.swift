//
//  Projectile.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/25/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class Projectile: SKSpriteNode {

  override init() {
    super.init()
    color = SKColor.blackColor()
    size = CGSizeMake(20, 20)
    name = "projectile"
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.dynamic = true
    physicsBody?.categoryBitMask = Category.Projectile
    physicsBody?.contactTestBitMask = Category.Ceiling
    physicsBody?.collisionBitMask = Category.None
    physicsBody?.usesPreciseCollisionDetection = true
  }
  
  override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

}
