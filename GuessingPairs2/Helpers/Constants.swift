//
//  ViewModel.swift
//  GuessingPairs2
//
//  Created by Mac on 05/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

var arrayOfPairs = [0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
//var arrayOfPairs = [0,0,1,1]
let imageBack = UIImage(named: "closeCard")!
let imageBackPressed = UIImage(named: "closeCardPressed")!
let imageOpen = UIImage(named: "openCard")!
let imagesCollection: [Int:String] = [0:"pig", 1:"monkey", 2:"cat", 3:"zebra", 4:"fox", 5:"tiger", 6:"dog", 7:"penguin"]
//let imagesCollection: [Int:String] = [0:"pig", 1:"monkey"]
let cardImageScaleMultiplier = 0.8

let arrayColumnsNumber: Int = 4
let arrayRowsNumber: Int = 4
let buttonsIndent: points = 0
let leadingViewOffset: points = 50

let maxNumOfRounds: Int = 5

let timerInterval: Double = 0.5
