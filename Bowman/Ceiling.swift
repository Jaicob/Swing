//
//  Ceiling.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/25/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class Ceiling: SKSpriteNode {
  
  override init() {
    super.init()
    name = "ceiling"
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.categoryBitMask = Category.Ceiling
    physicsBody?.contactTestBitMask = Category.Projectile
    physicsBody?.collisionBitMask = Category.None
    setUpPhysics()
  }
  
  override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    setUpPhysics()
  }
  
  init(location : CGPoint) {
    super.init()
    size = CGSizeMake(1090, 190)
    color = SKColor.grayColor()
    position = location
    name = "ceiling"
    setUpPhysics()
  }
  
  func setUpPhysics() {
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.dynamic = false
    physicsBody?.allowsRotation = false
    physicsBody?.pinned = false
    physicsBody?.affectedByGravity = false
    physicsBody?.categoryBitMask = Category.Ceiling
    physicsBody?.contactTestBitMask = Category.Projectile
    physicsBody?.collisionBitMask = Category.None
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
