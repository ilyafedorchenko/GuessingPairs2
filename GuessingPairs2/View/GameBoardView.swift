//
//  GameBoardView.swift
//  GuessingPairs2
//
//  Created by Mac on 05/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

class GameBoardView: UIView {

  var indent: points
  var leadingOffset: points
  var columnsNumber: Int
  
  init (_ backgroundColor: UIColor, _ indent: points, _ leadingOffset: points, _ columnsNumber: Int) {
    
    self.indent = indent
    self.leadingOffset = leadingOffset
    self.columnsNumber = columnsNumber
    
    super.init(frame: CGRect())
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.backgroundColor = backgroundColor
  }
  
  required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
  
  var buttonSize: Size {
    
    let maxSize = superview!.frame.maxY - (leadingOffset * 2)
    let buttonSize = ((maxSize - indent) / CGFloat(columnsNumber))
    return Size.init(width: buttonSize, height: buttonSize)

  }
  
  func setupConstraints () {
  
    let maxSize = superview!.frame.maxY - (leadingOffset * 2)
    self.heightAnchor.constraint(equalToConstant: maxSize).isActive = true
    self.widthAnchor.constraint(equalToConstant: maxSize).isActive = true
//    self.topAnchor.constraint(equalTo: superview!.topAnchor, constant: CGFloat(leadingOffset)).isActive = true
    self.centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
    self.centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
  
  }
  
}
