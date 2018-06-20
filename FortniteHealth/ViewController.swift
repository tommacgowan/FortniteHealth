//
//  ViewController.swift
//  FortniteHealth
//
//  Created by Tom Macgowan on 18/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //OUTLETS
    
    @IBOutlet weak var miniShield: UIButton!
    @IBOutlet weak var longGame: UIButton!
    @IBOutlet weak var mediumGame: UIButton!
    @IBOutlet weak var shortGame: UIButton!
    @IBOutlet weak var healthBar: UILabel!
    @IBOutlet weak var stormNotification: UILabel!
    @IBOutlet weak var healthView: UILabel!
    //VARS
    var gameTimer = Timer()
    var counter: Double = 100
    var gameState = 0
    var overallTime = 0
    var stormStart = 0
    
    //SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        healthView.alpha = 0
        miniShield.alpha = 0
        stormNotification.alpha = 0
        healthBar.alpha = 0
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MAIN
    @IBAction func miniShield(_ sender: UIButton) {
        if counter < 50 {
            if counter > 25 {
                counter = 50
            }
            else {
            counter = counter + 25
            }
        }
    }
    
    @IBAction func shortGame(_ sender: UIButton) {
        gameState = 0
        healthView.alpha = 1
        stormStart = Int(arc4random_uniform(2))
        //stormStart = 15 + Int(arc4random_uniform(61))
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(ViewController.updateGameState)), userInfo: nil, repeats: true)
        shortGame.isEnabled = false
        mediumGame.isEnabled = false
        longGame.isEnabled = false
        shortGame.alpha = 0
        mediumGame.alpha = 0
        longGame.alpha = 0
        miniShield.alpha = 1
    }
    @IBAction func mediumGame(_ sender: UIButton) {
        gameState = 1
        healthView.alpha = 1
        stormStart = 45 + Int(arc4random_uniform(181))
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(ViewController.updateGameState)), userInfo: nil, repeats: true)
        shortGame.isEnabled = false
        mediumGame.isEnabled = false
        longGame.isEnabled = false
        shortGame.alpha = 0
        mediumGame.alpha = 0
        longGame.alpha = 0
    }
    @IBAction func longGame(_ sender: UIButton) {
        gameState = 2
        healthView.alpha = 1
        stormStart = 90 + Int(arc4random_uniform(361))
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(ViewController.updateGameState)), userInfo: nil, repeats: true)
        shortGame.isEnabled = false
        mediumGame.isEnabled = false
        longGame.isEnabled = false
        shortGame.alpha = 0
        mediumGame.alpha = 0
        longGame.alpha = 0
    }
    @IBAction func actionTriggered(_ sender: UIButton) {
        //gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(ViewController.updateGameState)), userInfo: nil, repeats: true)
    }
    @objc func updateGameState () {
        overallTime = overallTime + 1
        if gameState == 0 && counter > 0 {
            if overallTime > stormStart && overallTime <= 480 {
                stormNotification.alpha = 1
                //counter = counter - (1/20)
                counter = counter - (5)
                healthView.text = String("\(Int(counter))/100")
            }
            else if overallTime > 480 && overallTime <= 720 {
                counter = counter - (2/20)
                healthView.text = String("\(Int(counter))/100")
            }
            else if overallTime > 720 && overallTime <= 960 {
                counter = counter - (5/20)
                healthView.text = String("\(Int(counter))/100")
            }
            else if overallTime > 960 && overallTime < 1200 {
                counter = counter - (10/20)
                healthView.text = String("\(Int(counter))/100")
            }
            else if overallTime == 1200 {
                
            }
        }
        if gameState == 1 && counter > 0 {
            if overallTime <= 1440 {
            }
            else if overallTime > 1440 && overallTime <= 2160 {
            }
            else if overallTime > 2160 && overallTime <= 2880 {
            }
            else if overallTime > 2880 && overallTime < 3600 {
            }
        }
        if gameState == 2 && counter > 0{
            if overallTime <= 2880 {
            }
            else if overallTime > 2880 && overallTime <= 4320 {
            }
            else if overallTime > 4320 && overallTime <= 5760 {
            }
            else if overallTime > 5760 && overallTime < 7200 {
            }
        }
        if counter == 0 {
            stormNotification.alpha = 0
            miniShield.isEnabled = false
            miniShield.alpha = 0
            healthView.text = String("You Died")
        }
    }
}
    
    
    

                
                
    
        
 

    
    
    
    
    

  


