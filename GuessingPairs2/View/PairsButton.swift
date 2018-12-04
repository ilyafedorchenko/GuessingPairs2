//
//  PairsButton.swift
//  GuessingPairs2
//
//  Created by Mac on 05/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

class PairsButton: UIButton {

  init(<#parameters#>) {
    <#statements#>
  
  
  
  }
  
  required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
  
  
  
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
  
  func fillArrayOfButtons (_ rowsNumber: Int, _ columnsNumber: Int, _ image: UIImage) {
    for i in 0...rowsNumber - 1 {
      for j in 0...columnsNumber - 1 {
        arrayOfButtons[i,j] = createButton(image)
      }
    }
  }
  
}
