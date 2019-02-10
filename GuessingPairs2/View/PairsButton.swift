//
//  PairsButton.swift
//  GuessingPairs2
//
//  Created by Mac on 05/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

class PairsButton: UIButton {

  init() {
    super.init(frame: CGRect())
    self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.fill
    self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.fill
    self.translatesAutoresizingMaskIntoConstraints = false
    self.isOpaque = true
//    self.setImage(imageBackPressed, for: .highlighted)
  }
  
  required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}

  
  func setupConstraints (_ board: UIView, _ size: Size, _ offsetX: points, _ offsetY: points) {
    
    self.leadingAnchor.constraint(equalTo: board.leadingAnchor, constant: offsetX).isActive = true
    self.topAnchor.constraint(equalTo: board.topAnchor, constant: offsetY).isActive = true
    self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    
  }
  
}
