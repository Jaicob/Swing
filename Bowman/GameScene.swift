//
//  GameScene.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/23/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  var player = PlayerSprite()
  let moveCeiling = SKAction.moveBy(CGVectorMake(-5, 0), duration: 0)
  
  override func didMoveToView(view: SKView) {
    player.position = CGPointMake(self.size.width * 0.1, self.size.height * 0.3)
    setupPhysicsWorld()
    
    let ceilingOne = Ceiling(location: CGPointMake(1572,700))
    let ceilingTwo = Ceiling(location: CGPointMake(2664,700))
    
    self.addChild(player)
    self.addChild(ceilingOne)
    self.addChild(ceilingTwo)
  }
  
  func setupPhysicsWorld() {
    physicsWorld.gravity = CGVectorMake(0, -1.3)
    physicsWorld.contactDelegate = self
  }
  
  override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    removeOldProjectile()
    
    let touch = touches.anyObject() as UITouch
    let touchLocation = touch.locationInNode(self)
    
    let projectile = Projectile()
    projectile.position = player.position
    
    let launchVector = calculateLaunchVectorUsing(touchLocation, projectile: projectile)
    projectile.physicsBody?.applyImpulse(launchVector)
  }
  
  func removeOldProjectile() {
    if self.childNodeWithName("projectile") != nil {
      self.childNodeWithName("projectile")?.removeFromParent()
    }
  }
  
  func calculateLaunchVectorUsing(location : CGPoint, projectile : SKSpriteNode) -> CGVector{
    let offset = location - projectile.position
    //if (offset.x < 0) { return CGVectorMake(0, 0)}//disables backwards shooting
    addChild(projectile)
    let direction = offset.normalized()
    let shootAmount = direction * 20
    let launchVector = CGVectorMake(shootAmount.x , shootAmount.y)
    return launchVector
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    print("HIT")
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
    projectile.physicsBody?.velocity = CGVectorMake(0, 0)
    joinPlayerWith(projectile)
    createPendulumJointWith(projectile, ceiling: ceiling)
    player.physicsBody?.applyImpulse(CGVectorMake(11, 0))
    self.childNodeWithName("floor")?.removeFromParent()
  }
  
  func createPendulumJointWith(projectile : SKSpriteNode, ceiling: SKSpriteNode) {
    let pendulumJoint = SKPhysicsJointPin.jointWithBodyA(ceiling.physicsBody, bodyB:projectile.physicsBody , anchor: projectile.position)
    self.physicsWorld.addJoint(pendulumJoint)
  }
  
  func joinPlayerWith(projectile : SKSpriteNode) {
    var newJoint = SKPhysicsJointFixed.jointWithBodyA(self.player.physicsBody, bodyB: projectile.physicsBody, anchor: CGPointMake(self.player.position.x + self.player.size.width / 2 , self.player.position.y))
    self.physicsWorld.addJoint(newJoint)
  }
  
  func moveTheCeilings() {
    self.enumerateChildNodesWithName("ceiling", usingBlock: { node, stop in
      if node.position.x <= -(node as SKSpriteNode).size.width {
        node.position = CGPointMake(node.position.x + (node as SKSpriteNode).size.width * 2, node.position.y)
      }
      (node as SKSpriteNode).runAction(self.moveCeiling)
    })
  }
  
  override func update(currentTime: CFTimeInterval) {
    self.moveTheCeilings()
  }
}
