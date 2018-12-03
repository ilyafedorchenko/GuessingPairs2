//
//  Cell.swift
//  GuessingPairs2
//
//  Created by Mac on 28/11/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import Foundation
import UIKit

typealias points = CGFloat

struct Point {
  let x: points
  let y: points
}

struct Size {
  let width: points
  let height: points
}

class Cell {
  let origin: Point
  let size: Size
  let frontImage: UIImage
  let backImage: UIImage

  required init (origin: Point, size: Size, frontImage: UIImage, backImage: UIImage) {

    self.origin = origin
    self.frontImage = frontImage
    self.backImage = backImage
    self.size = size

  }

}
