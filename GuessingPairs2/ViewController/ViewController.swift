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
  var arrayOfButtons = Matrix(rows: arrayRowsNumber, columns: arrayColumnsNumber, image: imageBack)
  
  @objc func buttonTouch (_ button: PairsButton) {
    
    let i = arrayOfButtons.grid.firstIndex(of: button)
    let index = arrayOfPairs[i!]
    let imageName = imagesCollection[index]
    button.setImage(UIImage(named : imageName!), for: .normal)
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    self.view.addSubview(gameBoard)
    gameBoard.setupConstraints()
    let buttonSize = gameBoard.buttonSize
    
    for row in 0...arrayRowsNumber - 1 {
      for column in 0...arrayColumnsNumber - 1 {
        let offsetY = leadingViewOffset + CGFloat(row) * (buttonSize.width + buttonsIndent)
        let offsetX = leadingViewOffset + CGFloat(column) * (buttonSize.width + buttonsIndent)
        let button = arrayOfButtons[row,column]
        gameBoard.addSubview(arrayOfButtons[row,column])
        button.setupConstraints(gameBoard, buttonSize, offsetX, offsetY)
        button.addTarget(button, action: #selector(buttonTouch), for: .touchUpInside)
      }
    }
    
    arrayOfPairs.shuffle()
    print(arrayOfPairs)
  
  }
}

