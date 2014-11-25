//
//  GameScene.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/23/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
  func sqrt(a: CGFloat) -> CGFloat {
  return CGFloat(sqrtf(Float(a)))
  }
#endif

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
  var player = PlayerSprite()
  let moveCeiling = SKAction.moveBy(CGVectorMake(-5, 0), duration: 0)
  
  override func didMoveToView(view: SKView) {
    player.position = CGPointMake(self.size.width * 0.1, self.size.height * 0.3)
    physicsWorld.gravity = CGVectorMake(0, -1.3)
    physicsWorld.contactDelegate = self
    
    var ceiling = self.childNodeWithName("ceiling") as SKSpriteNode
    ceiling.physicsBody?.categoryBitMask = Category.Ceiling
    ceiling.physicsBody?.contactTestBitMask = Category.Projectile
    ceiling.physicsBody?.collisionBitMask = Category.None
    
    ceiling = self.childNodeWithName("ceilingTwo") as SKSpriteNode
    ceiling.physicsBody?.categoryBitMask = Category.Ceiling
    ceiling.physicsBody?.contactTestBitMask = Category.Projectile
    ceiling.physicsBody?.collisionBitMask = Category.None
    
    var blueBox = SKSpriteNode(color: SKColor.blueColor(), size: CGSizeMake(70, 150))
    blueBox.position = CGPointMake(player.position.x*2 + player.size.width, player.position.y)
    blueBox.physicsBody = SKPhysicsBody(rectangleOfSize: blueBox.size)
    blueBox.physicsBody?.affectedByGravity = false
    blueBox.physicsBody?.dynamic = true
    blueBox.name = "blueBox"
    
    self.addChild(player)
  }
  
  override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {

    if self.childNodeWithName("projectile") != nil {
      self.childNodeWithName("projectile")?.removeFromParent()
    }
    
    //Choose one of the touches to work with
    let touch = touches.anyObject() as UITouch
    let touchLocation = touch.locationInNode(self)
    
    let scaleBoc = SKAction.scaleXBy(5, y: 1, duration: 2)
    let repeatScale = SKAction.repeatActionForever(scaleBoc)
    
    //Set up initial location of projectile
    let projectile = SKSpriteNode(color: SKColor.blackColor(), size: CGSizeMake(20, 20))
    projectile.position = player.position
    projectile.name = "projectile"
    projectile.physicsBody = SKPhysicsBody(rectangleOfSize: projectile.size)
    projectile.physicsBody?.affectedByGravity = false
    projectile.physicsBody?.dynamic = true
    projectile.physicsBody?.categoryBitMask = Category.Projectile
    projectile.physicsBody?.contactTestBitMask = Category.Ceiling
    projectile.physicsBody?.collisionBitMask = Category.None
    projectile.physicsBody?.usesPreciseCollisionDetection = true
    
    let offset = touchLocation - projectile.position
  //  if (offset.x < 0) { return }
    addChild(projectile)
    let direction = offset.normalized()
    let shootAmount = direction * 20
    let launchVector = CGVectorMake(shootAmount.x , shootAmount.y)
    projectile.physicsBody?.applyImpulse(launchVector)
  }
  
  
  func didBeginContact(contact: SKPhysicsContact) {
    
    
    var firstBody: SKPhysicsBody
    var secondBody: SKPhysicsBody
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    } else {
      firstBody = contact.bodyB
      secondBody = contact.bodyA
    }
    
    if ((firstBody.categoryBitMask & Category.Ceiling != 0) &&
      (secondBody.categoryBitMask & Category.Projectile != 0)) {
        projectileDidCollideWithCeiling(firstBody.node as SKSpriteNode, projectile: secondBody.node as SKSpriteNode)
    }
  }
  
  func projectileDidCollideWithCeiling(ceiling:SKSpriteNode, projectile:SKSpriteNode) {
    
    println("Hit")
    projectile.physicsBody?.velocity = CGVectorMake(0, 0)
    
    var newJoint = SKPhysicsJointFixed.jointWithBodyA(self.player.physicsBody, bodyB: projectile.physicsBody, anchor: CGPointMake(self.player.position.x + self.player.size.width / 2 , self.player.position.y))
    
    self.physicsWorld.addJoint(newJoint)
    projectile.physicsBody?.dynamic = true
    projectile.physicsBody?.affectedByGravity = false
    
    let pendulumJoint = SKPhysicsJointPin.jointWithBodyA(ceiling.physicsBody, bodyB:projectile.physicsBody , anchor: projectile.position)
    self.physicsWorld.addJoint(pendulumJoint)
    
    let moveCeiling = SKAction.moveBy(CGVectorMake(ceiling.size.width * -2, 0), duration: 5)
    player.physicsBody?.applyImpulse(CGVectorMake(11, 0))
    
    self.childNodeWithName("floor")?.removeFromParent()
  }
  
  func moveTheCeilings() {
    self.enumerateChildNodesWithName("ceiling", usingBlock: { node, stop in
      if node.position.x <= -(node as SKSpriteNode).size.width {
        node.position = CGPointMake(node.position.x + (node as SKSpriteNode).size.width * 2, node.position.y)
      }
       (node as SKSpriteNode).runAction(self.moveCeiling)
    })
    self.enumerateChildNodesWithName("ceilingTwo", usingBlock: { node, stop in
      if node.position.x <= -(node as SKSpriteNode).size.width {
        node.position = CGPointMake(node.position.x + (node as SKSpriteNode).size.width * 2, node.position.y)
      }
      (node as SKSpriteNode).runAction(self.moveCeiling)
    })
    
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
    self.moveTheCeilings()
  }
}
