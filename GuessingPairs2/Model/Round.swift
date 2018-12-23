//
//  Round.swift
//  GuessingPairs2
//
//  Created by Mac on 08/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

class Round {
  
  var currentRound: Int = 0
  var moveIsOver: Bool = false
  var previousField: UIButton? = nil
  var currentField: UIButton? = nil
  var players: [Player]
  var labelRound: UILabel
  var maxScoreSum: Int
  
  
  required init(_ players: [Player], _ labelRound: UILabel, maxScoreSum: Int) {

    self.players = players
    self.labelRound = labelRound
    self.maxScoreSum = maxScoreSum
    
  }
  
  // Start next round logic:
  //
  
  func startNewRound() {
    
    if (players[0].playerScore > 0) || (players[1].playerScore > 0) {
    // NEW Round initialisation (not FIRST)
      if players[0].playerScore > players[1].playerScore {
        players[0].unhideNextCup()
      } else if players[0].playerScore < players[1].playerScore {
        players[1].unhideNextCup()
      } else {
        players[0].unhideNextCup()
        players[1].unhideNextCup()
      }
    }
    // general for any round initialisation
    self.resetScores()
    currentRound += 1
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
  
  // sets score to 0 for each player, update score labels
  func resetScores() {
    for player in players {
      player.playerScore = 0
      player.labelPlayerScore.text = "\(player.playerScore)"
    }
  }
  
  func checkEndOfRound () -> Bool {
    let sumScores = players.reduce(0, {result, player in result + player.playerScore})
    if sumScores < maxScoreSum {
      return false
    } else {
      return true
    }
  }
}
