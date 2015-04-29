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
  

  
  init(position: CGPoint) {
    var color = SKColor.redColor()
    var size = CGSizeMake(15, 15)
    super.init(texture: nil, color: color, size: size)
    self.position = position
    self.name = "marker"
    self.zPosition = 1000
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
