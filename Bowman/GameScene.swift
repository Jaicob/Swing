//
//  GameScene.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/23/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//


//TODO Clean up the codes
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  var player = PlayerSprite()
  let moveCeiling = SKAction.moveBy(CGVectorMake(-5, 0), duration: 0)
  let startPosition = CGPointMake(70,520)
  let playerStart = CGPointMake(70,522)

  var updatesCalled = 0

  override func didMoveToView(view: SKView) {
    player.position = CGPointMake(self.size.width * 0.045, 554)
    setupPhysicsWorld()
    
    let ceilingOne = Ceiling(location: CGPointMake(572,750))
    let ceilingTwo = Ceiling(location: CGPointMake(2664,700))
    
    let wall = WallSprite()
    let ledge = LedgeSprite()
    ledge.physicsBody?.categoryBitMask = Category.Platform
    ledge.name = "currentLedge"
    let targetLedge = LedgeSprite(location: CGPointMake(622, 270))
    targetLedge.size = CGSizeMake(100, 25)
    
    //setup target
    let target = self.childNodeWithName("target")
    //  target?.physicsBody?.categoryBitMask = Category.TargetPlatform
    //target?.physicsBody?.contactTestBitMask = Category.None
    
    self.addChild(player)
    //self.addChild(wall)
    self.addChild(ledge)
    self.addChild(targetLedge)
    self.addChild(ceilingOne)
    self.addChild(ceilingTwo)
  }
  
  
  func setupPhysicsWorld() {
    physicsWorld.gravity = CGVectorMake(0, -9.8)
    physicsWorld.contactDelegate = self
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    let touch = touches.anyObject()
    let touchLocation = touch?.locationInNode(self)
    

  }
  
  override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
    println("touch cancelled")
  }
  
  override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    println("touch ended")
    
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
    addChild(projectile)
    let direction = offset.normalized()
    let shootAmount = direction * 5
    
    let launchVector = CGVectorMake(shootAmount.x , shootAmount.y)
    return launchVector
  }
  
  
  func detectCollisionType(contact: SKPhysicsContact) -> CollisionType{
    let bodyA = contact.bodyA.collisionBitMask
    let bodyB = contact.bodyB.collisionBitMask
    
    if bodyB & bodyA == CollisionType.collisionMasks[CollisionType.ProjectileAndCeiling] {
      return CollisionType.ProjectileAndCeiling
    } else if bodyB & bodyA == CollisionType.collisionMasks[CollisionType.PlayerAndPlatform] {
      return CollisionType.PlayerAndPlatform
    }
    return CollisionType.None
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    //    switch detectCollisionType(contact) {
    //
    //    case .PlayerAndPlatform:
    //      println("player and platform")
    //    case .ProjectileAndCeiling:
    //      projectileDidCollideWithCeiling(contact.bodyA.node as SKSpriteNode, projectile: contact.bodyB.node as SKSpriteNode)
    //    default:
    //      println("not recognized")
    //    }
    
    
    if(updatesCalled == 0) {return}
    updatesCalled = 0
    
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
    
    if ((firstBody.categoryBitMask & Category.Player != 0) ||
      (secondBody.categoryBitMask & Category.TargetPlatform != 0)){
        playerDidContactPlatform(secondBody.node as LedgeSprite)
    } else if ((secondBody.categoryBitMask & Category.Player != 0) ||
    (firstBody.categoryBitMask & Category.TargetPlatform != 0)) {
      playerDidContactPlatform(firstBody.node as LedgeSprite)
    }
  }
  
  func playerDidContactPlatform(platform : LedgeSprite) {
    println("player contacted platform")
    if platform.name == "currentLedge" {return}
    platform.physicsBody?.categoryBitMask = Category.Platform
    let moveLedgeUp = SKAction.moveTo(startPosition, duration: 1)
    let movePlayerUp = SKAction.moveTo(playerStart, duration: 1)
    player.runAction(movePlayerUp)
    platform.name = "currentLedge"
    platform.runAction(moveLedgeUp, completion: { () -> Void in
      
    })
    self.generateNextPlatform()
  }
  
  func generateNextPlatform() {
    var randomX  = CGFloat(random() % 700 + 500)
    var randomSize = CGFloat(random() % 120 + 40)
    
    let targetLedge = LedgeSprite(location: CGPointMake(1022, -270), size:CGSizeMake(randomSize, 25))
    let moveIntoPlace = SKAction.moveTo(CGPointMake(randomX, 270), duration: 1)
    self.addChild(targetLedge)
    targetLedge.runAction(moveIntoPlace)
  }
  
  func projectileDidCollideWithCeiling(ceiling:SKSpriteNode, projectile:SKSpriteNode) {
    println("projectile and Ceiling")
    projectile.physicsBody?.velocity = CGVectorMake(0, 0)
    joinPlayerWith(projectile)
    createPendulumJointWith(projectile, ceiling: ceiling)
    self.childNodeWithName("currentLedge")?.removeFromParent()
    player.physicsBody?.applyImpulse(CGVectorMake(10, 0))
    
  }
  
  
  func createPendulumJointWith(projectile : SKSpriteNode, ceiling: SKSpriteNode) {
    let pendulumJoint = SKPhysicsJointPin.jointWithBodyA(ceiling.physicsBody, bodyB:projectile.physicsBody , anchor: projectile.position)
    self.physicsWorld.addJoint(pendulumJoint)
  }
  
  
  func joinPlayerWith(projectile : SKSpriteNode) {
    var newJoint = SKPhysicsJointPin.jointWithBodyA(self.player.physicsBody, bodyB: projectile.physicsBody, anchor: CGPointMake(self.player.position.x + self.player.size.width / 2 , self.player.position.y))
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
  
  func reset() {
    println("Inside Reset")
    self.removeAllChildren()
    self.removeAllActions()
   
    player.position = CGPointMake(self.size.width * 0.045, 554)
    setupPhysicsWorld()
    
    let ceilingOne = Ceiling(location: CGPointMake(572,750))
    let ceilingTwo = Ceiling(location: CGPointMake(2664,700))
    
    let wall = WallSprite()
    let ledge = LedgeSprite()
    ledge.physicsBody?.categoryBitMask = Category.Platform
    ledge.name = "currentLedge"
    let targetLedge = LedgeSprite(location: CGPointMake(622, 270))
    targetLedge.size = CGSizeMake(100, 25)
    
    let target = self.childNodeWithName("target")
    self.addChild(player)
    self.addChild(ledge)
    self.addChild(targetLedge)
    self.addChild(ceilingOne)
    self.addChild(ceilingTwo)
    
  }
  
  override func update(currentTime: CFTimeInterval) {
    updatesCalled++
    if let projectile = self.childNodeWithName("projectile") {
      if player.physicsBody?.velocity.dx <= 10 && player.physicsBody?.velocity.dy > 2  {
        println("x < 20 and y > 0")
        projectile.removeFromParent()
        physicsWorld.removeAllJoints()
      }
    }
    
    if player.position.y < 0 {
      player.removeFromParent()
    }
    
    if self.childNodeWithName("player") == nil  {
      reset()
    }
  }
  
}
