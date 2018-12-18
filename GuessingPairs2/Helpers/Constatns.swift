//
//  ViewModel.swift
//  GuessingPairs2
//
//  Created by Mac on 05/12/2018.
//  Copyright © 2018 HardSoft inc. All rights reserved.
//

import UIKit

//var arrayOfPairs = [0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
var arrayOfPairs = [0,0,1,1]
let imageBack = UIImage(named: "Question")!
//let imagesCollection: [Int:String] = [0:"Arrow", 1:"Polygone", 2:"Roomb", 3:"Circle", 4:"Square", 5:"6_Star", 6:"Star", 7:"Triangle"]÷
let imagesCollection: [Int:String] = [0:"Arrow", 1:"Polygone"]

let arrayColumnsNumber: Int = 2
let arrayRowsNumber: Int = 2
let buttonsIndent: points = 8
let leadingViewOffset: points = 8

let maxNumOfRounds: Int = 3

let timerInterval: Double = 1.0
