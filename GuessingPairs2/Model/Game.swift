//
//  Game.swift
//  GuessingPairs2
//
//  Created by Mac on 08/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

class Game {
  
  var players: [Player]
  let maxNumOfRounds: Int

  required init (_ players: [Player], _ maxNumOfRounds: Int) {
    self.players = players
    self.maxNumOfRounds = maxNumOfRounds
  }
  
  
  
  func countCups (_ arrayOfCups: [UIImageView]) -> Int {
    var counter = 0
    for i in arrayOfCups {
      if !i.isHidden {
        counter += 1
      }
    }
    return counter
  }
  
  
  func checkGameOver (_ round: Int) -> Bool {
    if round == maxNumOfRounds {
      return true
    } else {
      return false
    }
  }
  
  

}
