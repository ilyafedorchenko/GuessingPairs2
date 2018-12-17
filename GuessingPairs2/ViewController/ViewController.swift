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
  
  @IBOutlet weak var labelPlayer_1: UILabel!
  @IBOutlet weak var labelPlayer_2: UILabel!
  @IBOutlet weak var labelPlayer_1Score: UILabel!
  @IBOutlet weak var labelPlayer_2Score: UILabel!
  @IBOutlet weak var labelRound: UILabel!
  
  
  var gameBoard = GameBoardView(UIColor.gray, buttonsIndent, leadingViewOffset, arrayColumnsNumber)
  var arrayOfButtons = Matrix(rows: arrayRowsNumber, columns: arrayColumnsNumber, image: imageBack)
  var currentField: UIButton?
  var previousField: UIButton?

  // FIXME: temporary players are hardcoded
  var players: [Player] = []
  var round: Round?
  var game: Game?
  var moveIsOver: Bool = false
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
  
    players = [
      Player.init(
        name: "Father",
        playerActiveTurn: true,
        playerScore: 0,
        labelPlayer: labelPlayer_1,
        labelPlayerScore: labelPlayer_1Score,
        playerCups: player_1_Cups
      ),
      Player.init(
        name: "Varya",
        playerActiveTurn: false,
        playerScore: 0,
        labelPlayer: labelPlayer_2,
        labelPlayerScore: labelPlayer_2Score,
        playerCups: player_2_Cups
      )
    ]
    game = Game(players, maxNumOfRounds)
    round = Round(round: 1, players, labelRound)
    
    setupGameBoard()
    
    
  }
  
  
  @objc func buttonTouch (_ button: PairsButton) {
    //FIXME: add correct round change and cup increment
    if !moveIsOver {
      openButton(button)
      previousField = button
      moveIsOver = true
    } else {
      openButton(button)
      currentField = button
      moveIsOver = false
      if !checkPairs(currentField!, previousField!) {
        closeButtons(currentField!, previousField!, imageBack)
        round!.switchActivePlayer()
      } else {
        closeButtons(currentField!, previousField!, nil)
        for (index,_) in players.enumerated() {
          players[index].activePlayerScorePlus()
        }
        if true {
          
          //TODO: round is NOT over?
          round!.startNewRound()

        } else {
          if game!.checkGameOver(round!.currentRound) { //TODO: games is over?
            
            showGameOverAlert()
          } else {
            // label game over
            setupGameBoard()
          }
        }
      }
    }
  }
  
  
  
  func openButton (_ button: PairsButton) {
    let i = arrayOfButtons.grid.firstIndex(of: button)
    let index = arrayOfPairs[i!]
    let imageName = imagesCollection[index]
    button.setImage(UIImage(named : imageName!), for: .normal)
  }
  
  func setupGameBoard() {
    arrayOfPairs.shuffle()
    round!.startNewRound()
    
    self.view.addSubview(gameBoard)
    gameBoard.setupConstraints()
    let buttonSize = gameBoard.buttonSize
    moveIsOver = false
    
    for row in 0..<arrayRowsNumber {
      for column in 0..<arrayColumnsNumber {
        let offsetY = leadingViewOffset + CGFloat(row) * (buttonSize.width + buttonsIndent)
        let offsetX = leadingViewOffset + CGFloat(column) * (buttonSize.width + buttonsIndent)
        let button = arrayOfButtons[row,column]
        gameBoard.addSubview(arrayOfButtons[row,column])
        button.setupConstraints(gameBoard, buttonSize, offsetX, offsetY)
        button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
      }
    }
    for (index, _) in players.enumerated() {
      if players[index].playerActiveTurn {
        players[index].labelPlayer.backgroundColor = UIColor.red
      } else {
        players[index].labelPlayer.backgroundColor = UIColor.gray
      }
    }
  }

  //Alert function for game over
  func showGameOverAlert() {
    
    //TODO: add message for each player
    let message = "Game over!"
    
//    if countCups(arrayOfP1Cups) > countCups(arrayOfP2Cups) {
//      //P1 won
//      message = "Game over!\nPlayer 1 wins!"
//    } else if countCups(arrayOfP1Cups) < countCups(arrayOfP2Cups) {
//      //P2 won
//      message = "Game over!\nPlayer 2 wins!"
//    } else {
//      // Draw
//      message = "Game over!\nDraw!"
//    }
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction (title: "OK", style: .default, handler: {
      action in
//      self.startNewRound(startNewGame: true)
    })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  //func for updating labels + debugging
//  func updateLabels(){
//    labelRoundOver.text=String(moveOver)                                // DEBUG----------------------
//    //        labelTotalScore.text=String(totalScore)                           // DEBUG----------------------
//    labelNumberOfPairsRevealed.text=String(numberOfPairsRevealed)       // DEBUG----------------------
//    labelP1Score.text=String(playerScore[0])
//    labelP2Score.text=String(playerScore[1])
//    labelActivePlayer.text=String(activePlayer)
//    labelActiveRound.text="\(String(activeRound))/\(String(roundsMax))"
//  }
  
  //close 2 fields with timerInterval delay settin image to ?, to hide button set image to nil
  func closeButtons (_ currentField: UIButton, _ previousField: UIButton, _ imageBack: UIImage?) {

      let _ = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: false) {
        timer in
        // do stuff X seconds later
        if let image = imageBack {
          currentField.setImage(image, for: .normal)
          previousField.setImage(image, for: .normal)
        } else {
          currentField.imageView!.isHidden = true
          previousField.imageView!.isHidden = true
        }
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
