//
//  GameOver.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/27/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class GameOver: SKSpriteNode {
  var restart : SKSpriteNode!
  
  override init() {
    super.init()
    name = "gameOver"
    size = CGSizeMake(1028, 754)
    color = SKColor.clearColor()
    zPosition = Layer.MainMenu
    layoutSubNodes()
  }
  
  func layoutSubNodes() {
    var restart = SKSpriteNode(color: SKColor.lightGrayColor(), size: CGSizeMake(90, 90))
    restart.position = CGPointMake(self.position.x, self.position.y)
    restart.zPosition = Layer.MainMenu
    restart.alpha = 1
    restart.name = "restart"
    var restartText = SKLabelNode(text: "Restart")
    restartText.fontColor = SKColor.whiteColor()
    restartText.fontSize = 24
    restartText.fontName = UIFont.boldSystemFontOfSize(20).fontName
    restartText.zPosition = Layer.MainMenu
    restartText.name = "restart"
    restart.addChild(restartText)
    self.restart = restart
    self.addChild(restart)
    
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
