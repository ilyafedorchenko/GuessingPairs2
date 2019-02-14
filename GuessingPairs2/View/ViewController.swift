//
//  ViewController.swift
//  GuessingPairs2
//
//  Created by Mac on 28/11/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
 
  @IBOutlet var player_1_Cups: [UIImageView]!
  @IBOutlet var player_2_Cups: [UIImageView]!
  @IBOutlet weak var blueBackView: UIImageView!
  
  @IBOutlet weak var rightPlayerImage: UIImageView!
  @IBOutlet weak var leftPlayerImage: UIImageView!
  
  @IBOutlet weak var labelPlayer_1: UILabel!
  @IBOutlet weak var labelPlayer_2: UILabel!
  @IBOutlet weak var labelPlayer_1Score: UILabel!
  @IBOutlet weak var labelPlayer_2Score: UILabel!
  @IBOutlet weak var labelRound: UILabel!
  
  var gameBoard = GameBoardView(UIColor.clear, buttonsIndent, leadingViewOffset, arrayColumnsNumber)
  var arrayOfButtons = Matrix(rows: arrayRowsNumber, columns: arrayColumnsNumber)
  
  var currentField: UIButton?
  var previousField: UIButton?

  // TODO: temporary players are hardcoded, should be passed from Menue
  var players: [Player] = []
  var round: Round?
  var game: Game?
  var moveIsOver: Bool = false
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
  
    players = [
      Player.init(
        name: "Илья",
        playerActiveTurn: true,
        playerScore: 0,
        labelPlayer: labelPlayer_1,
        playerImage: leftPlayerImage!,
        labelPlayerScore: labelPlayer_1Score,
        playerCups: player_1_Cups
      ),
      Player.init(
        name: "Даша",
        playerActiveTurn: false,
        playerScore: 0,
        labelPlayer: labelPlayer_2,
        playerImage: rightPlayerImage!,
        labelPlayerScore: labelPlayer_2Score,
        playerCups: player_2_Cups
      )
    ]
    game = Game(players, maxNumOfRounds)
    round = Round(players, labelRound, maxScoreSum: arrayOfPairs.count/2)
    self.view.addSubview(gameBoard)
    gameBoard.setupConstraints()
    
    setupGameBoard()
    
  }
  
  
  @objc func buttonTouch (_ button: PairsButton) {
    if button == previousField {return}
    if !moveIsOver {                                                           // move is NOT over, open next Field
      openButton(button)
      previousField = button
      moveIsOver = true
    } else {                                                                   // move is over, start checking pair
      openButton(button)
      currentField = button
      moveIsOver = false
      
      //TODO: add press blocker to avoid speed clicking
      
      let _ = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: false) {
        timer in
      
        // start of timer closure
      
        if !self.checkPairs(self.currentField!, self.previousField!) {          // pair is NOT guessed, close pair and switch player
          self.closeButtons(self.currentField!, self.previousField!, imageBack)
          self.round!.switchActivePlayer()
      } else {                                                                  // pair is guessed, hide pair and disable, increase score
          self.closeButtons(self.currentField!, self.previousField!, nil)
          for player in self.players {
            player.activePlayerScorePlus()
        }
          if self.round!.checkEndOfRound() {                                     // round is over
            self.round!.startNewRound()                                          // give a cup to the winner, reset scores
            self.resetAllButtons(self.arrayOfButtons)                            // reset all buttons, shuffle
          // TODO: optional alert
            if self.game!.checkGameOver(self.round!.currentRound) {              // games is over
              if let winner = self.game!.getPlayerWinner() {
                self.showGameOverAlert(winner)                                   // show alert with the winner
              } else {
                self.showGameOverAlert(nil)
              }
            }
          }
        }
      
        // end of timer closure
      
      }
    }                                                                          // active player can make new move
  }
  
  
  
  func openButton (_ button: PairsButton) {
    let i = arrayOfButtons.grid.firstIndex(of: button)
    let index = arrayOfPairs[i!]
    let imageName = imagesCollection[index]
    let image = UIImage(named : imageName!)
//    let resizedImage = image?.resizableImage(withCapInsets: UIEdgeInsets(top: -2, left: -2, bottom: -2, right: -2), resizingMode: .stretch)
    button.setImage(image, for: .normal)
    button.setBackgroundImage(imageOpen, for: .normal)
    button.setBackgroundImage(nil, for: .highlighted)
//    button.isEnabled = false
  }
  
  func resetAllButtons(_ buttons: Matrix) {
    for row in 0..<arrayRowsNumber {
      for column in 0..<arrayColumnsNumber {
        buttons[row,column].isEnabled = true
        buttons[row,column].isHidden = false
        buttons[row,column].setBackgroundImage(imageBack, for: .normal)
        buttons[row,column].setImage(nil, for: .normal)
        
      }
    }
    arrayOfPairs.shuffle()
  }
  
  func setupGameBoard() {
    
    arrayOfPairs.shuffle()
    round!.startNewRound()
    
    let buttonSize = gameBoard.buttonSize
    moveIsOver = false
    
    for row in 0..<arrayRowsNumber {
      for column in 0..<arrayColumnsNumber {
        let offsetY = CGFloat(row) * (buttonSize.width + buttonsIndent)
        let offsetX = CGFloat(column) * (buttonSize.width + buttonsIndent)
        let button = arrayOfButtons[row,column]
        gameBoard.addSubview(arrayOfButtons[row,column])
        button.setupConstraints(gameBoard, buttonSize, offsetX, offsetY)
        button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
        button.setBackgroundImage(imageBack, for: .normal)
        button.setBackgroundImage(imageBackPressed, for: .highlighted)
      }
    }
//    for (index, _) in players.enumerated() {
//      if players[index].playerActiveTurn {
//        //players[index].labelPlayer.backgroundColor = UIColor.red
//      } else {
//        players[index].labelPlayer.backgroundColor = UIColor.gray
//      }
//    }
  }

  //Alert function for game over
  func showGameOverAlert(_ player: Player?) {
    
    labelRound.text = ""
    
    let message: String
    
    if let player = player {
      message = "\(player.name) wins!\nGame over."
    } else {
      message = "Draw!\nGame over."
    }
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction (title: "Restart", style: .default, handler: {
      action in
        self.round!.currentRound = 0
        self.setupGameBoard()
        self.game!.hideCups()
    })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  func closeButtons (_ currentField: UIButton, _ previousField: UIButton, _ imageBack: UIImage?) {
      if let image = imageBack {
        currentField.setBackgroundImage(image, for: .normal)
        currentField.setBackgroundImage(imageBackPressed, for: .highlighted)
        currentField.setImage(nil, for: .normal)
        currentField.isEnabled = true
        previousField.setBackgroundImage(image, for: .normal)
        previousField.setBackgroundImage(imageBackPressed, for: .highlighted)
        previousField.setImage(nil, for: .normal)
        previousField.isEnabled = true
      } else {
        currentField.isHidden = true
        previousField.isHidden = true
      }

  }
  
  // Iterates through Cups collection and unHides the first hidden
  func giveACup (_ arrayOfCups: [UIImageView]) {
    for i in arrayOfCups {
      if i.isHidden {
        i.isHidden = false
        break
      }
    }
  }
  
  // Iterates through Cups collection and Hides ALL
  func eraseCups (_ arrayOfCups: [UIImageView]) {
    for i in arrayOfCups {
      i.isHidden = true
    }
  }
  
  // Check if images on the buttons are equal, returns true/false
  func checkPairs (_ firstField: UIButton, _ secondField: UIButton) -> Bool {
    if firstField.currentImage == secondField.currentImage {
      return true
    } else {
      return false
    }
  }

}
