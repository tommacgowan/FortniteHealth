//
//  GameViewController.swift
//  FortniteHealth
//
//  Created by Tom Macgowan on 21/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var stormNotification: UIImageView!
    @IBOutlet weak var bigShield: UIButton!
    @IBOutlet weak var healthBarBackground: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var miniShield: UIButton!
    @IBOutlet weak var healthBar: UIImageView!
    @IBOutlet weak var healthView: UILabel!
    @IBOutlet weak var chugShield: UIButton!
    var gameTimer = Timer()
    var checkDrinkTimer = Timer()
    var audioPlayer = AVAudioPlayer()
    
    let miniShieldSound = Bundle.main.url(forResource: "miniShield", withExtension: "mp3")
    let bigShieldSound = Bundle.main.url(forResource: "bigShield", withExtension: "mp3")
    let chugJugSound = Bundle.main.url(forResource: "chugJug", withExtension: "mp3")
    
    var miniDrinkTime: Double = 2.2
    var bigDrinkTime: Double = 5.3
    var chugDrinkTime: Double = 15
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        healthBar.setWidth(width: 2.5*CGFloat(global.counter))
        global.counter = global.startingHealth
        stormNotification.alpha = 0
        
        //determine game type and setup storm settings
        if global.gameType == "short"
        {
            global.stormStart = Int(arc4random_uniform(121))
            global.stormTimes = [global.stormStart, 480, 720, 960, 1200]
            global.stormDamages = [0, 0.01, 0.02, 0.05, 0.1]
        }
        else if global.gameType == "medium"
        {
            global.stormStart = Int(arc4random_uniform(301))
            global.stormTimes = [global.stormStart, 1440, 2160, 2880, 3600]
            global.stormDamages = [0, 0.0365, 0.0731, 0.183, 0.365]
        }
        else if global.gameType == "long"
        {
            global.stormStart = Int(arc4random_uniform(481))
            global.stormTimes = [global.stormStart, 2880, 4320, 5760, 7200]
            global.stormDamages = [0, 0.0256, 0.512, 0.128, 0.256]
        }
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(GameViewController.updateGameState)), userInfo: nil, repeats: true)
        
        checkDrinkTimer = Timer.scheduledTimer(timeInterval: 0.3, target:self, selector: (#selector(GameViewController.checkDrink)), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //FUNCTIONS
    
    //miniShieldUsed
    @IBAction func miniShield(_ sender: UIButton)
    {
        if round(global.counter) < 50
        {
            drinkDelay(time: miniDrinkTime, type: "mini")
            do
            {
                audioPlayer = try AVAudioPlayer(contentsOf: miniShieldSound!)
                audioPlayer.play()
            }
            catch
            {
                
            }
        }
    }
    
    //bigShieldUsed
    @IBAction func bigShield(_ sender: UIButton)
    {
        if round(global.counter) != 100
        {
            drinkDelay(time: bigDrinkTime, type: "big")
            do
            {
                audioPlayer = try AVAudioPlayer(contentsOf: bigShieldSound!)
                audioPlayer.play()
            }
            catch
            {
            
            }
        }
    }
    
    //chugShieldUsed
    @IBAction func chugShield(_ sender: UIButton)
    {
        if round(global.counter) != 100
        {
            drinkDelay(time: chugDrinkTime, type: "chug")
            do
            {
                audioPlayer = try AVAudioPlayer(contentsOf: chugJugSound!)
                audioPlayer.play()
            }
            catch
            {
            
            }
        }
    }
    
    //update game state
    @objc func updateGameState ()
    {
       
        global.overallTime = global.overallTime + 1
        
        if Int(global.overallTime) > global.stormTimes[0] && Int(global.overallTime) <= global.stormTimes[1]
        {
            stormNotification.alpha = 1
            global.damageStep = global.stormDamages[1]
            global.counter = global.counter - global.damageStep
            updateView()
        }
        else if Int(global.overallTime) <= global.stormTimes[2]
        {
            global.damageStep = global.stormDamages[2]
            global.counter = global.counter - global.damageStep
            updateView()
        }
        else if Int(global.overallTime) <= global.stormTimes[3]
        {
            global.damageStep = global.stormDamages[3]
            global.counter = global.counter - global.damageStep
            updateView()
        }
        else if Int(global.overallTime) < global.stormTimes[4]
        {
            global.damageStep = global.stormDamages[4]
            global.counter = global.counter - global.damageStep
            updateView()
        }
        else if Int(global.overallTime) >= global.stormTimes[4]
        {
            //after final storm????
        }
        
        if global.counter <= 0
        {
            if miniShield.isEnabled == false
            {
            audioPlayer.stop()
            }
            performSegue(withIdentifier: "segueToDeath", sender: nil)
        }
        
    }
    
    
    @IBAction func homeButton(_ sender: UIButton) {
        clearGameState()
        if miniShield.isEnabled == false
        {
            audioPlayer.stop()
        }
        performSegue(withIdentifier: "segueToHome", sender: nil)
    }
    
    func clearGameState()
    {
        global.overallTime = 0
        global.counter = 100
        global.gameType = ""
        gameTimer.invalidate()
    }
    
    func updateView()
    {
        healthView.text = String("\(Int(round(global.counter)))/100")
        healthBar.setWidth(width: 2.5*CGFloat(global.counter))
    }
    
    func drink(type: String)
    {
        if type == "mini"
        {
            if global.counter < 50
            {
                if global.counter > 25
                {
                    global.counter = 50
                }
                else
                {
                    global.counter = global.counter + 25
                }
            }
        }
        else if type == "big"
        {
            if global.counter > 50
            {
                global.counter = 100
            }
            else
            {
                global.counter = global.counter + 50
            }
               
        }
        else if type == "chug"
        {
            global.counter = 100
        }
    }
    
    func drinkDelay(time: Double, type: String)
    {
        global.drinking = true
        let startTime = CFAbsoluteTimeGetCurrent()
        global.finishDrink = startTime + time
        global.drinkType = type
        miniShield.isEnabled = false
        bigShield.isEnabled = false
        chugShield.isEnabled = false
        miniShield.alpha = 0.5
        bigShield.alpha = 0.5
        chugShield.alpha = 0.5
    }
    @objc func checkDrink()
    {
        if (global.finishDrink < CFAbsoluteTimeGetCurrent()) && (global.drinking == true)
        {
            drink(type: global.drinkType)
            updateView()
            global.drinking = false
            miniShield.isEnabled = true
            bigShield.isEnabled = true
            chugShield.isEnabled = true
            miniShield.alpha = 1
            bigShield.alpha = 1
            chugShield.alpha = 1
         }
    }
}
