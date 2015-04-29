//
//  MainMenu.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/26/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class MainMenu: SKSpriteNode {
  var startButton : SKSpriteNode!

  
   init() {
    var size = CGSizeMake(1028, 754)
    var color = SKColor.clearColor()
    super.init(texture: nil, color: color, size: size)
    name = "mainMenu"
    zPosition = Layer.MainMenu
    layoutSubNodes()
  }
  
  func layoutSubNodes() {
    var startButton = SKSpriteNode(color: SKColor.lightGrayColor(), size: CGSizeMake(90, 90))
    startButton.position = CGPointMake(self.position.x, self.position.y)
    startButton.zPosition = Layer.MainMenu
    startButton.alpha = 1
    startButton.name = "start"
    var startText = SKLabelNode(text: "Start")
    startText.fontColor = SKColor.whiteColor()
    startText.fontSize = 24
    startText.fontName = UIFont.boldSystemFontOfSize(20).fontName
    startText.zPosition = Layer.MainMenu
    startText.name = "start"
    startButton.addChild(startText)
    self.startButton = startButton
    self.addChild(startButton)
    
    let modal = SKSpriteNode(color: UIColor.blackColor(), size: self.size)
    modal.alpha = 0.5
    modal.zPosition = Layer.Background
    modal.name = "modal"
    self.addChild(modal)
  }
  
  override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
}
