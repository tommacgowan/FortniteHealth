//
//  global.swift
//  myPicolo
//
//  Created by Heath Rusby on 18/6/18.
//  Copyright © 2018 Heath Rusby. All rights reserved.
//
import UIKit

class Global
{
    var gameType: String = ""
    var startingHealth: Double = 100
    var overallTime: Double = 0
    var timeLeft: Double = 0
    var timeReturned: Double = 0
    var downTime: Double = 0
    var counter: Double = 100
    var damageStep: Double = 0
    var stormStart = 0
    var stormTimes: [Int] = [0,0,0,0,0]
    var stormDamages = [0.0,0.0,0.0,0.0,0.0]
    var drinking: Bool = false
    var finishDrink: Double = 0
    var drinkType: String = ""
    var gameTimer = Timer()
    var checkDrinkTimer = Timer()
    var stormCount = 0
    var revived = false
    var hasShot: Int = 0
    var shotTime = 0
    var doneShot = true
    var fromBackground = false
    var gameOn = false
    var boogieTime = 0
    var hasBoogie: Int = 0
    var doneBoogie = true
    var isDead = false
    var minDif = 5 //dont change as this is overwritten when short, medium or long is clicked
    
}
let global  = Global()
