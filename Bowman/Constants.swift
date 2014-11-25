//
//  Constants.swift
//  Bowman
//
//  Created by Jaicob Stewart on 11/24/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

import Foundation
import UIKit

struct Category {
  static let None :       UInt32 = 0
  static let All  :       UInt32 = UInt32.max
  static let Ceiling :    UInt32 = 1
  static let Projectile:  UInt32 = 2
}


struct Layer {
  static let Background: CGFloat = 0
  static let Rope: CGFloat = 1
  static let Foreground: CGFloat = 3
}
