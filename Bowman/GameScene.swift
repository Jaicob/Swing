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
  let startPosition = CGPointMake(70,520)
  let playerStart = CGPointMake(70,522)
  var points = -1
  var score :SKLabelNode!
  
  var updatesCalled = 0
  
  override init(size: CGSize) {
    super.init(size: size)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  //MARK: - Setup code
  override func didMoveToView(view: SKView) {
    player.position = CGPointMake(self.size.width * 0.045, 554)
    setupPhysicsWorld()
    setupScene()
    
    let mainMenu = MainMenu()
    mainMenu.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5)
    self.addChild(mainMenu)
  }
  
  func setupScene() {
    player.position = CGPointMake(self.size.width * 0.045, 554)
    setupPhysicsWorld()
    let ceilingOne = Ceiling(location: CGPointMake(540,750))
    let ceilingTwo = Ceiling(location: CGPointMake(2664,700))
    let wall = WallSprite()
    let ledge = LedgeSprite()
    ledge.physicsBody?.categoryBitMask = Category.Platform
    ledge.name = "currentLedge"
    let targetLedge = LedgeSprite(location: CGPointMake(622, 270))
    targetLedge.size = CGSizeMake(100, 15)
    let target = self.childNodeWithName("target")
    score = SKLabelNode(text: String(points))
    score.position = CGPointMake(500, 580)
    score.fontColor = SKColor.blackColor()
    
    self.addChild(player)
    self.addChild(ledge)
    self.addChild(targetLedge)
    self.addChild(ceilingOne)
    self.addChild(ceilingTwo)
    self.addChild(score)
  }
  
  func setupPhysicsWorld() {
    physicsWorld.gravity = CGVectorMake(0, -9.8)
    physicsWorld.contactDelegate = self
  }
  
  
  
  //MARK: - Touch handling
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    let touch = touches.anyObject() as UITouch
    let touchLocation = touch.locationInNode(self)
    
    if let mainMenu = self.childNodeWithName("mainMenu") {
      return
    }
    if let gameOver = self.childNodeWithName("gameOver") {
      return
    }
    if let gameOver = self.childNodeWithName("modal") {
      return
    }
    
    let marker = Marker(position: CGPointMake(player.position.x, 650))
    self.addChild(marker)
    marker.runAction(marker.moveRight, withKey: "moveRight")
  }
  
  override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    let touch = touches.anyObject() as UITouch
    let touchLocation = touch.locationInNode(self)
    
    //TODO: make another method
    if let mainMenu = self.childNodeWithName("mainMenu") {
      if self.nodeAtPoint(touchLocation) == mainMenu.childNodeWithName("start") {
        mainMenu.removeFromParent()
        return
      }
      return
    }
    
    //TODO: make another method
    if let gameOver = self.childNodeWithName("gameOver") {
      if self.nodeAtPoint(touchLocation) == gameOver.childNodeWithName("restart") {
        gameOver.removeFromParent()
        reset()
        return
      }
      return
    }
    
    if let gameOver = self.childNodeWithName("modal") {
      return
    }
    
    let marker = self.childNodeWithName("marker")
    marker?.removeActionForKey("moveRight")
    removeNode("projectile")
    shootProjectile(marker!.position)
  }
  
  override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
    println("touch cancelled")
  }
  
  
  
  //MARK: - Node Interactions
  func shootProjectile(target : CGPoint) {
    let projectile = Projectile()
    projectile.position = player.position
    addChild(projectile)
    let launchVector = calculateLaunchVectorUsing(target, projectile: projectile)
    projectile.physicsBody?.applyImpulse(launchVector)
  }
  
  func calculateLaunchVectorUsing(location : CGPoint, projectile : SKSpriteNode) -> CGVector{
    let offset = location - projectile.position
    let direction = offset.normalized()
    let shootAmount = direction * 5
    let launchVector = CGVectorMake(shootAmount.x , shootAmount.y)
    return launchVector
  }
  
  func generateNextPlatform() {
    //could make this into a function that returns a tuple
    var randomX  = CGFloat(random() % 700 + 400)
    var randomY  = CGFloat(random() % 220 + 200)
    var randomSize = CGFloat(random() % 90 + 40)
    
    let targetLedge = LedgeSprite(location: CGPointMake(1022, -270), size:CGSizeMake(randomSize, 15))
    let moveIntoPlace = SKAction.moveTo(CGPointMake(randomX, randomY), duration: 1)
    self.addChild(targetLedge)
    targetLedge.runAction(moveIntoPlace)
  }
  
  
  func createPendulumJointWith(projectile : SKSpriteNode, ceiling: SKSpriteNode) {
    let pendulumJoint = SKPhysicsJointPin.jointWithBodyA(ceiling.physicsBody, bodyB:projectile.physicsBody , anchor: projectile.position)
    
    var context = UIGraphicsGetCurrentContext()
    var path = CGPathCreateMutable()
    var bodyPath = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, player.position.x + 10, player.position.y + 10)
    CGPathAddLineToPoint(path, nil, projectile.position.x - 15, projectile.position.y - 15)
    
    CGPathMoveToPoint(bodyPath, nil, player.position.x + 10, player.position.y + 10)
    CGPathAddLineToPoint(bodyPath, nil, projectile.position.x - 0, projectile.position.y - 5)
    CGPathAddLineToPoint(bodyPath, nil, projectile.position.x - 0, projectile.position.y - 0)
    CGPathAddLineToPoint(bodyPath, nil, player.position.x + 10, player.position.y + 15)
    CGPathAddLineToPoint(bodyPath, nil, player.position.x + 10, player.position.y + 10)
    
    var rope = SKShapeNode(path: bodyPath)
    rope.fillColor = SKColor.blackColor()
    rope.strokeColor = SKColor.blackColor()
    rope.lineWidth = 2
    rope.name = "rope"
    rope.physicsBody = SKPhysicsBody(polygonFromPath: bodyPath)
    rope.physicsBody?.affectedByGravity = true
    rope.physicsBody?.dynamic = true
    rope.physicsBody?.allowsRotation = true
    rope.physicsBody?.categoryBitMask = Category.None
    rope.physicsBody?.collisionBitMask = Category.None
    rope.physicsBody?.contactTestBitMask = Category.None
    self.addChild(rope)
    
    let playerAndRope = SKPhysicsJointPin.jointWithBodyA(player.physicsBody, bodyB: rope.physicsBody, anchor: CGPointMake(player.position.x + player.size.width / 2, player.position.y))
    self.physicsWorld.addJoint(playerAndRope)
    
    
    let projectileAndRope = SKPhysicsJointPin.jointWithBodyA(projectile.physicsBody, bodyB: rope.physicsBody, anchor: CGPointMake(projectile.position.x, projectile.position.y))
    self.physicsWorld.addJoint(projectileAndRope)
    
    self.physicsWorld.addJoint(pendulumJoint)
  }
  
  func joinPlayerWith(projectile : SKSpriteNode) {
    var newJoint = SKPhysicsJointPin.jointWithBodyA(self.player.physicsBody, bodyB: projectile.physicsBody, anchor: CGPointMake(self.player.position.x + self.player.size.width / 2 , self.player.position.y))
    self.physicsWorld.addJoint(newJoint)
  }
  
  func removeNode(name: String) {
    if let node = self.childNodeWithName(name) {
      node.removeFromParent()
    }
  }
  
  func reset() {
    self.removeAllChildren()
    self.removeAllActions()
    points = -1
    setupScene()
  }
  
  
  //Could possibly make a colliosn handling class
  //MARK: - Collsion Handling
  func didBeginContact(contact: SKPhysicsContact) {
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
    if player.position.y - platform.position.y <= 15 {
      return
    }
    points++
    score.text = String(points)
    if platform.name == "currentLedge" {return}
    platform.physicsBody?.categoryBitMask = Category.Platform
    let moveLedgeUp = SKAction.moveTo(startPosition, duration: 1)
    let movePlayerUp = SKAction.moveTo(playerStart, duration: 1)
    player.runAction(movePlayerUp)
    platform.name = "currentLedge"
    platform.runAction(moveLedgeUp, completion: { () -> Void in
      self.userInteractionEnabled = true
    })
    self.generateNextPlatform()
  }
  
  func projectileDidCollideWithCeiling(ceiling:SKSpriteNode, projectile:SKSpriteNode) {
    self.userInteractionEnabled = false;
    removeNode("marker")
    projectile.physicsBody?.velocity = CGVectorMake(0, 0)
    joinPlayerWith(projectile)
    createPendulumJointWith(projectile, ceiling: ceiling)
    self.childNodeWithName("currentLedge")?.removeFromParent()
    player.physicsBody?.applyImpulse(CGVectorMake(10, 0))
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
  
  func gameOver() {
    updateHighscore()
    self.userInteractionEnabled = true;
    let gameOverMenu = GameOver()
    gameOverMenu.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5)
    self.addChild(gameOverMenu)
  }
  
  //MARK: User Data/Settings
  
  func updateHighscore(){
    let userDefaults =  NSUserDefaults.standardUserDefaults()
    if let highscore = userDefaults.valueForKey("highscore") as? Int {
      if points > highscore {
        userDefaults.setInteger(points, forKey: "highscore")
      }
    } else {
      userDefaults.setInteger(points, forKey: "highscore")
    }
  }
  
  //MARK: - Game loop
  override func update(currentTime: CFTimeInterval) {
    updatesCalled++
    
    if self.childNodeWithName("gameOver") != nil {
      return
    }
    if player.position.y < 0 && self.childNodeWithName("gameOver") == nil {
      gameOver()
      return
    }
    
    if let projectile = self.childNodeWithName("projectile") {
      if player.physicsBody?.velocity.dx <= 15 && player.physicsBody?.velocity.dy > 1  {
        projectile.removeFromParent()
        self.childNodeWithName("rope")?.removeFromParent()
        physicsWorld.removeAllJoints()
      }
    }
  }
  
}
