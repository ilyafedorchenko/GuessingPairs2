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
    for player in players {
      for cup in player.playerCups{
          cup.isHidden = true
      }
    }
  }
  
  func checkGameOver (_ currentRound: Int) -> Bool {
 
    // Game is over if one player gets overwelming number of cups or rounds are over
    
    for player in players {
      if player.numberOfCups == Int(maxNumOfRounds/2) + maxNumOfRounds%2 {return true}
    }
    
    if (currentRound > maxNumOfRounds) {
      return true
    } else {
      return false
    }
  }
  
  func getPlayerWinner() -> Player? {
    
    // Get player that has max Cups or Nil
    
    if players[0].numberOfCups > players[1].numberOfCups {
      return players[0]
    } else if players[0].numberOfCups < players[1].numberOfCups {
      return players[1]
    } else {
      return nil
    }
  }
  
  func hideCups() {
    for player in players {
      player.hideCups()
    }
  }
  
}
