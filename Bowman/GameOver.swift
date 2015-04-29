//
//  GameOver.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/27/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
  
  override init(size: CGSize) {
    
    super.init(size: size)
    
    // 1
    backgroundColor = SKColor.whiteColor()
    
    // 2
    var message = "You Lose :["
    
    // 3
    let label = SKLabelNode(fontNamed: "Chalkduster")
    label.text = message
    label.fontSize = 40
    label.fontColor = SKColor.blackColor()
    label.position = CGPoint(x: size.width/2, y: size.height/2)
    addChild(label)
    
    // 4
    runAction(SKAction.sequence([
      SKAction.waitForDuration(3.0),
      SKAction.runBlock() {
        println("INITING GAME OVER SCENE")
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        let scene = GameScene(size: size)
        scene.backgroundColor = SKColor.whiteColor()
        self.view?.presentScene(scene, transition:reveal)
      }
      ]))
    
  }
  
  // 6
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
