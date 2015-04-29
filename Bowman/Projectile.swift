//
//  Projectile.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/25/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class Projectile: SKSpriteNode {
  
  
  
  override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
    var color = SKColor.clearColor()
    var size = CGSizeMake(10, 10)

    super.init(texture: nil, color: color, size: size)
    name = "projectile"
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.affectedByGravity = false
    physicsBody?.dynamic = true
    physicsBody?.categoryBitMask = Category.Projectile
    physicsBody?.contactTestBitMask = Category.Ceiling
    physicsBody?.collisionBitMask = Category.None
    physicsBody?.usesPreciseCollisionDetection = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
