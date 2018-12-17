//
//  Round.swift
//  GuessingPairs2
//
//  Created by Mac on 08/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

class Round {
  
  var currentRound: Int
  var moveIsOver: Bool = false
  var previousField: UIButton? = nil
  var currentField: UIButton? = nil
  var players: [Player]
  var labelRound: UILabel
  
  
  required init(round: Int, _ players: [Player], _ labelRound: UILabel) {
    
    self.currentRound = round
    self.players = players
    self.labelRound = labelRound
    
  }
  
  // Start next round logic:
  //
  
  func startNewRound() {
    
    if (players[0].playerScore > 0) || (players[1].playerScore > 0) {
      // NEW Round initialisation (not FIRST)
      if players[0].playerScore > players[1].playerScore {
        //TODO: P1 won add cup
        self.resetScores()
      } else if players[0].playerScore < players[1].playerScore {
        //TODO: P2 won add cup
        self.resetScores()
      } else {
        //TODO: Draw add 2 cups
        self.resetScores()
      }
    } else {
      // FIRST Round initialisation
      // just reset scores
      self.resetScores()
    }
    
    labelRound.text = "Round: \(currentRound) of \(maxNumOfRounds)"
    
  }
  
  // switches activePlayer
  func switchActivePlayer() {
    
    for (index, _) in players.enumerated() {
      players[index].playerActiveTurn.toggle()
      if players[index].playerActiveTurn {
        players[index].labelPlayer.backgroundColor = UIColor.red
      } else {
        players[index].labelPlayer.backgroundColor = UIColor.gray
      }
    }
  }
  
  // sets score to 0 for each player
  func resetScores() {
    
    for (index, _) in players.enumerated() {
      players[index].playerScore = 0
    }
  }
  
  
  
  
}
