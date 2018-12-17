//
//  Player.swift
//  GuessingPairs2
//
//  Created by Mac on 08/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit


class Player {
  
  let name: String
  var playerActiveTurn: Bool
  var playerScore: Int
  var labelPlayer: UILabel
  var labelPlayerScore: UILabel
  var playerCups: [UIImageView]
  
  init(name: String, playerActiveTurn: Bool, playerScore: Int, labelPlayer: UILabel, labelPlayerScore: UILabel, playerCups: [UIImageView]) {
    self.name = name
    self.playerActiveTurn = playerActiveTurn
    self.playerScore = playerScore
    self.labelPlayer = labelPlayer
    self.labelPlayerScore = labelPlayerScore
    self.playerCups = playerCups
    self.labelPlayer.text = name
  }
  
  func activePlayerScorePlus () {
    if playerActiveTurn {
      playerScore += 1
      labelPlayerScore.text = "\(playerScore)"
    }
  }
}
