//
//  ViewController.swift
//  GuessingPairs2
//
//  Created by Mac on 28/11/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

struct Matrix {
  let rows: Int, columns: Int
  var grid: [UIButton]
  
  init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
    grid = Array (repeating: UIButton(), count: rows * columns)
  }
  
  func indexIsValid (row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }
  
  subscript (row: Int, column: Int) -> UIButton {
    get {
      assert(indexIsValid(row: row, column: column), "Index out of range")
      return grid[(row * columns) + column]
    }
    set {
      assert(indexIsValid(row: row, column: column), "Index out of range")
      grid[(row * columns) + column] = newValue
    }
    
  }
  
}

let arrayColumnsNumber = 4
let arrayRowsNumber = 4
let buttonsIndent: points = 8
let leadingViewOffset: points = 8

class ViewController: UIViewController {
  
  var gameBoard: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.gray
    return view
  }()
  
  let imageBack = UIImage(named: "Question")!
  let imagesCollection: [Int:String] = [0:"Arrow", 1:"Polygone", 2:"Roomb", 3:"Circle", 4:"Square", 5:"6_Star", 6:"Star", 7:"Triangle"]
  var arrayOfPairs = [0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
  
  var arrayOfButtons = Matrix(rows: arrayRowsNumber, columns: arrayColumnsNumber)
  var imageView: UIImageView!
  
  @objc func buttonTouch (_ button: UIButton) {
    
    let i = arrayOfButtons.grid.firstIndex(of: button)
    let index = arrayOfPairs[i!]
    
    let imageName = imagesCollection[index]
    button.setImage(UIImage(named : imageName!), for: .normal)
    
  }
  
  func buttonHide (_ button: UIButton) {
    button.setImage(imageBack, for: .normal)
  }
  
  func createButton (_ image: UIImage) -> UIButton {
    
    let button = UIButton()
    button.setImage(image, for: .normal)
    button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.fill
    button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.fill
    button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }
  
  func setupButtonConstraints (_ button: UIButton, _ board: UIView, _ size: Size, _ offsetX: points, _ offsetY: points) {
    
    button.leadingAnchor.constraint(equalTo: board.leadingAnchor, constant: offsetX).isActive = true
    button.topAnchor.constraint(equalTo: board.topAnchor, constant: offsetY).isActive = true
    button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    
  }
  
  func setupGameBoardConstraints (_ board: UIView, _ view: UIView, _ indent: points, _ leadingOffset: points, _ columnsNumber: Int) -> Size {
    
    let maxSize = view.frame.maxY - (leadingOffset * 2)
    let buttonSize = ((maxSize - indent) / CGFloat(columnsNumber)) - leadingOffset
    
    board.heightAnchor.constraint(equalToConstant: maxSize).isActive = true
    board.widthAnchor.constraint(equalToConstant: maxSize).isActive = true
    board.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(leadingOffset)).isActive = true
    board.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    return Size.init(width: buttonSize, height: buttonSize)
    
  }
  
  
  func fillArrayOfButtons (_ rowsNumber: Int, _ columnsNumber: Int, _ image: UIImage) {
    for i in 0...rowsNumber - 1 {
      for j in 0...columnsNumber - 1 {
        arrayOfButtons[i,j] = createButton(image)
      }
    }
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(gameBoard)
    let buttonSize = setupGameBoardConstraints(gameBoard, self.view, buttonsIndent, leadingViewOffset, arrayColumnsNumber)
    
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

