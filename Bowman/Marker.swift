//
//  Marker.swift
//  Bowman
//
//  Created by Jaicob Stewart on 1/6/15.
//  Copyright (c) 2015 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class Marker: SKSpriteNode {
  
  let moveRight = SKAction.moveToX(1200, duration: 1.5)
  
  override init() {
    super.init()
    
  }
  
  init(position: CGPoint) {
    super.init()
    self.position = position
    self.color = SKColor.redColor()
    self.size = CGSizeMake(15, 15)
    self.name = "marker"
    self.zPosition = 1000
  }
  
  override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
