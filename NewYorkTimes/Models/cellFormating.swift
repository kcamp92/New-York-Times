//
//  cellFormating.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 10/4/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit
struct CustomLayer{
   static let shared = CustomLayer()
   func createCustomlayer(layer:CALayer){
       layer.borderWidth = 2
       layer.borderColor = UIColor.black.cgColor
       layer.masksToBounds = true
       layer.shadowColor = UIColor.black.cgColor
       layer.shadowOffset = CGSize(width: 0, height: 5.0)
       layer.shadowRadius = 20.0
       layer.shadowOpacity = 0.5
       layer.masksToBounds = false
    layer.cornerRadius = 20
   }
}

