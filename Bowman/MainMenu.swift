//
//  MainMenu.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/26/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
  
  override init(size: CGSize) {
    
    super.init(size: size)
    
    backgroundColor = SKColor.whiteColor()
    
    var message = "Start"
    let label = SKLabelNode(fontNamed: "Chalkduster")
    label.name = "Start Button"
    label.text = message
    label.fontSize = 40
    label.fontColor = SKColor.blackColor()
    label.position = CGPoint(x: size.width/2, y: size.height/2)
    addChild(label)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  //MARK: - Touch Handling
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    let touch = touches.first as! UITouch
    let touchLocation = touch.locationInNode(self)
    if (self.childNodeWithName("Start Button")?.containsPoint(touchLocation) != nil) {
      //present game scene
      if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
        // Configure the view.
        let skView = self.view! as SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.showsPhysics = false
        //
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        //              skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
      }
    }
  }
  
  
}
