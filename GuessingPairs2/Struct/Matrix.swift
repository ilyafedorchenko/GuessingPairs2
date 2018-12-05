//
//  Matrix.swift
//  GuessingPairs2
//
//  Created by Mac on 05/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

struct Matrix {
  let rows: Int, columns: Int
  var grid: [PairsButton]
  
  init(rows: Int, columns: Int, image: UIImage) {
    self.rows = rows
    self.columns = columns
    grid = Array (repeating: PairsButton(image), count: rows * columns)
    for (i, _) in grid.enumerated() {
      let button = PairsButton(image)
      grid[i] = button
    }
    
    print(grid)
  }
  
  func indexIsValid (row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }
  
  subscript (row: Int, column: Int) -> PairsButton {
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
