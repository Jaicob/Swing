//
//  GameViewController.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/23/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import UIKit
import SpriteKit
import iAd

extension SKNode {
  class func unarchiveFromFile(file : NSString) -> SKNode? {
    if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
      var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
      var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
      
      archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
      let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
      archiver.finishDecoding()
      return scene
    } else {
      return nil
    }
  }
}

class GameViewController: UIViewController, ADBannerViewDelegate {
  
  var adBannerView = ADBannerView(frame: CGRect.zeroRect)
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    
//    if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
//      // Configure the view.
//      let skView = self.view as! SKView
//      skView.showsFPS = false
//      skView.showsNodeCount = false
//      skView.showsPhysics = false
//      
//      /* Sprite Kit applies additional optimizations to improve rendering performance */
//      skView.ignoresSiblingOrder = true
//      
//      /* Set the scale mode to scale to fit the window */
//      scene.scaleMode = .AspectFill
//      
//      skView.presentScene(scene)
//      loadAds()
//    } else {
      let scene = MainMenuScene(size: view.bounds.size)
      let skView = self.view as! SKView
      skView.showsFPS = false
      skView.showsNodeCount = false
      skView.showsPhysics = false
      skView.ignoresSiblingOrder = true
      scene.scaleMode = .AspectFill
      skView.presentScene(scene)
      loadAds()
//    }
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func supportedInterfaceOrientations() -> Int {
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
    } else {
      return Int(UIInterfaceOrientationMask.All.rawValue)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  func loadAds() {
    adBannerView.center = CGPoint(x: adBannerView.center.x + 100, y: view.bounds.size.height - adBannerView.frame.size.height / 2)
    adBannerView.delegate = self
    view.addSubview(adBannerView)
  }
  //iAd bannerView
  func bannerViewWillLoadAd(banner: ADBannerView!) {
    
  }
  
  func bannerViewDidLoadAd(banner: ADBannerView!){
    // println("1")
    adBannerView.hidden = false //now show banner as ad is loaded
  }
  
  func bannerViewActionDidFinish(banner: ADBannerView!) {
    // println("2")
  }
  
  func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
    //Tap to view the ad
    //scene.paused = true
    // println("3")
    return true
  }
  
  func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
    // adBannerView.hidden = true
    // println("44444")
  }
  
}
