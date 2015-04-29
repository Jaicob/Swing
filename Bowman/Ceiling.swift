//
//  Ceiling.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/25/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class Ceiling: SKSpriteNode {
  
//  override init(texture: SKTexture, color: UIColor, size: CGSize) {
//   // super.init()
//    super.init(texture: texture, color: SKColor.grayColor(), size: CGSizeMake(1090, 190))
//    name = "ceiling"
//    physicsBody = SKPhysicsBody(rectangleOfSize: size)
//    physicsBody?.categoryBitMask = Category.Ceiling
//    physicsBody?.contactTestBitMask = Category.Projectile
//    physicsBody?.collisionBitMask = Category.None
//    setUpPhysics()
//  }
  
  override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    setUpPhysics()
  }
  
  init(location : CGPoint) {
    var size = CGSizeMake(1090, 190)
    var color = SKColor.grayColor()
    super.init(texture: nil, color: color, size: size)
    self.position = location
    self.name = "ceiling"
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
