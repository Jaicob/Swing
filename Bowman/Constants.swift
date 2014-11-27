//
//  Constants.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/24/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//


//TODO:Figure out a good way to seperate these files
import Foundation
import SpriteKit
import UIKit

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

//Configurations
struct Layer {
  static let Background:  CGFloat = 0
  static let Rope:        CGFloat = 1
  static let Foreground:  CGFloat = 3
}

struct Category {
  static let None :           UInt32 = 0
  static let Ceiling :        UInt32 = 1
  static let Projectile:      UInt32 = 2
  static let TargetPlatform:  UInt32 = 4
  static let Player:          UInt32 = 8
  static let Platform:        UInt32 = 16
  static let All  :           UInt32 = UInt32.max
}

enum CollisionType: UInt32 {
  case ProjectileAndCeiling
  case PlayerAndPlatform
  case None
  
  static let collisionMasks = [
    ProjectileAndCeiling : Category.Projectile & Category.Ceiling,
    PlayerAndPlatform    : Category.Player & Category.TargetPlatform
  ]
  
  func mask() -> UInt32 {
    return 1
  }
  

}

