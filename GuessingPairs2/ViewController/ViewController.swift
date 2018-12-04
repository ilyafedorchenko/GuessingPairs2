//
//  ViewController.swift
//  GuessingPairs2
//
//  Created by Mac on 28/11/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
  
  var gameBoard = GameBoardView(UIColor.gray, buttonsIndent, leadingViewOffset, arrayColumnsNumber)
  
    override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(gameBoard)
      
    let buttonSize = gameBoard.buttonSize
    
    fillArrayOfButtons(arrayColumnsNumber, arrayRowsNumber, imageBack)
    
    for row in 0...arrayRowsNumber - 1 {
      for column in 0...arrayColumnsNumber - 1 {
        let offsetY = leadingViewOffset + CGFloat(row) * (buttonSize.width + buttonsIndent)
        let offsetX = leadingViewOffset + CGFloat(column) * (buttonSize.width + buttonsIndent)
        gameBoard.addSubview(arrayOfButtons[row,column])
        setupButtonConstraints(arrayOfButtons[row,column], gameBoard, buttonSize, offsetX, offsetY)
      }
    }
    
    arrayOfPairs.shuffle()
    print(arrayOfPairs)
  
  }
}

