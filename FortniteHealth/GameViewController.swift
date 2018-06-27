//
//  GameViewController.swift
//  FortniteHealth
//
//  Created by Tom Macgowan on 21/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class GameViewController: UIViewController {
    
    @IBOutlet var buttonBackgrounds: [UIImageView]!
    @IBOutlet var deathPopUp: UIView!
    @IBOutlet var boogiePopUp: UIView!
    @IBOutlet weak var stormCounter: UIImageView!
    @IBOutlet var shotPopUp: UIView!
    @IBOutlet weak var stormNotification: UIImageView!
    @IBOutlet weak var bigShield: UIButton!
    @IBOutlet weak var healthBarBackground: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var miniShield: UIButton!
    @IBOutlet weak var healthBar: UIImageView!
    @IBOutlet weak var healthView: UILabel!
    @IBOutlet weak var chugShield: UIButton!
    
    
    var audioPlayer = AVAudioPlayer()
     let deathSound = Bundle.main.url(forResource: "deathSound", withExtension: "mp3")
    let buttonPress = Bundle.main.url(forResource: "buttonPress", withExtension: "mp3")
    let miniShieldSound = Bundle.main.url(forResource: "miniShield", withExtension: "mp3")
    let bigShieldSound = Bundle.main.url(forResource: "bigShield", withExtension: "mp3")
    let chugJugSound = Bundle.main.url(forResource: "chugJug", withExtension: "mp3")
    
    var miniDrinkTime: Double = 2.2
    var bigDrinkTime: Double = 5.3
    var chugDrinkTime: Double = 15
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        global.gameOn = true
        global.overallTime = 0
        healthBar.setWidth(width: 2.5*CGFloat(global.counter))
        global.counter = global.startingHealth
        miniShield.isEnabled = true
        bigShield.isEnabled = true
        chugShield.isEnabled = true
        miniShield.alpha = 1
        bigShield.alpha = 1
        chugShield.alpha = 1
        for i in buttonBackgrounds
        {
            i.alpha = 1
        }
        
        stormSetup()
        setBoogieShot()
        
        //begin timers
        global.gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(GameViewController.updateGameState)), userInfo: nil, repeats: true)
        global.checkDrinkTimer = Timer.scheduledTimer(timeInterval: 0.3, target:self, selector: (#selector(GameViewController.checkDrink)), userInfo: nil, repeats: true)
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
    
    //Done button pressed
    @IBAction func doneButton(_ sender: UIButton)
    {
        self.shotPopUp.removeFromSuperview()
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
    }
    
    @IBAction func doneButton2(_ sender: UIButton)
    {
        self.boogiePopUp.removeFromSuperview()
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
    }
    //need to somehow only increament overalltime on player death.
    //update game state
    @objc func updateGameState ()
    {
        
        global.overallTime = global.overallTime + 1
        NSLog("%f", global.overallTime)
        if global.isDead == false
        {
            if Int(global.overallTime) <= global.stormTimes[0]
            {
                global.stormCount = 0
                stormNotification.alpha = 0
                //before storm starts
            }
            else if Int(global.overallTime) <= global.stormTimes[1]
            {
                global.stormCount = 1
                stormNotification.alpha = 1
                global.damageStep = global.stormDamages[1]
                global.counter = global.counter - global.damageStep
                updateView()
            }
            else if Int(global.overallTime) <= global.stormTimes[2]
            {
                global.stormCount = 2
                 stormNotification.alpha = 1
                global.damageStep = global.stormDamages[2]
                global.counter = global.counter - global.damageStep
                updateView()
            }
            else if Int(global.overallTime) <= global.stormTimes[3]
            {
                global.stormCount = 3
                 stormNotification.alpha = 1
                global.damageStep = global.stormDamages[3]
                global.counter = global.counter - global.damageStep
                updateView()
            }
            else if Int(global.overallTime) < global.stormTimes[4]
            {
                global.stormCount = 4
                 stormNotification.alpha = 1
                global.damageStep = global.stormDamages[4]
                global.counter = global.counter - global.damageStep
                updateView()
            }
            else if Int(global.overallTime) >= global.stormTimes[4]
            {
                //after final storm????
                clearGameState()
                if miniShield.isEnabled == false
                {
                    audioPlayer.stop()
                }
                performSegue(withIdentifier: "segueGameToEnd", sender: nil)
            }
            if global.counter <= 0
            {
                global.counter = 100
                self.shotPopUp.removeFromSuperview()
                if miniShield.isEnabled == false
                {
                    audioPlayer.stop()
                }
                displayPopUp(view: "death")
            }
        }
        checkBoogieShot()
        //NSLog("GameTime = %f | Counter = %f", global.overallTime, global.counter)
    }
    
    
    @IBAction func homeButton(_ sender: UIButton) {
        clearGameState()
        if miniShield.isEnabled == false
        {
            audioPlayer.stop()
        }
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
        performSegue(withIdentifier: "segueToHome", sender: nil)
    }
    
    func updateView()
    {
        if global.counter < 0
        {
            global.counter = 0
        }
        healthView.text = String("\(Int(round(global.counter)))/100")
        healthBar.setWidth(width: 2.5*CGFloat(global.counter))
        if (global.stormCount == 0)
        {
            stormCounter.alpha = 0
        }
        else if (global.stormCount == 1)
        {
            let newImg: UIImage? = UIImage(named: "1stStorm")
            stormCounter.image = newImg
            stormCounter.alpha = 1
        }
        else if (global.stormCount == 2)
        {
            let newImg: UIImage? = UIImage(named: "2ndStorm")
            stormCounter.image = newImg
            stormCounter.alpha = 1
        }
        else if (global.stormCount == 3)
        {
            let newImg: UIImage? = UIImage(named: "3rdStorm")
            stormCounter.image = newImg
            stormCounter.alpha = 1
        }
        else if (global.stormCount == 4)
        {
            let newImg: UIImage? = UIImage(named: "finalStorm")
            stormCounter.image = newImg
            stormCounter.alpha = 1
        }
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
        for i in buttonBackgrounds
        {
            i.alpha = 0.5
        }
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
            for i in buttonBackgrounds
            {
                i.alpha = 1
            }
         }
    }
    
    func clearGameState()
    {
        global.drinking = false
        global.doneShot = true
        global.doneBoogie = true
        global.drinkType = ""
        global.gameType = ""
        global.overallTime = 0
        global.counter = 100
        global.gameType = ""
        global.stormCount = 0
        global.gameTimer.invalidate()
        global.checkDrinkTimer.invalidate()
        global.revived = false
        global.isDead = false
    }
    
    func setBoogieShot()
    {
        if global.revived == false
        {
            let min = global.stormTimes[0] + 30
            let max = global.stormTimes[4] - 30
            if global.hasShot == 1 && global.hasBoogie != 1 //shot only
            {
                global.shotTime = min + Int(arc4random_uniform(UInt32(max - min + 1)))
                global.doneShot = false
                NSLog("Has shot at %d",global.shotTime)
                NSLog("No Boogie this time")
            }
            else if global.hasBoogie == 1 && global.hasShot != 1 //boogie only
            {
                global.boogieTime = min + Int(arc4random_uniform(UInt32(max - min + 1)))
                global.doneBoogie = false
                NSLog("No Shot this time")
                NSLog("Has Boogie at %d",global.boogieTime)
            }
            else if global.hasBoogie == 1 && global.hasShot == 1 //both shot and boogie
            {
                var dif: Int = 0
                while dif < global.minDif //TESTING difference needs to increase to approx 30 seconds
                {
                    global.boogieTime = min + Int(arc4random_uniform(UInt32(max - min + 1)))
                    global.shotTime = min + Int(arc4random_uniform(UInt32(max - min + 1)))
                    dif = Int(abs(global.shotTime - global.boogieTime))
                }
                global.doneBoogie = false
                global.doneShot = false
                NSLog("Has shot at %d",global.shotTime)
                NSLog("Has Boogie at %d",global.boogieTime)
            }
            else
            {
                NSLog("No boogie or shot")
            }
        }
    }
    
    func checkBoogieShot()
    {
        //if both boogie and shot are scheduled to display
        if Int(global.overallTime) >= global.shotTime && global.doneShot == false && Int(global.overallTime) >= global.boogieTime && global.doneBoogie == false
        {
            if global.boogieTime < global.shotTime
            {
                if global.isDead == true
                {
                    global.doneBoogie = true
                }
                else
                {
                    //NSLog("1")
                    displayPopUp(view: "boogiePopUp")
                    global.doneShot = true
                }
            }
            else
            {
                if global.isDead == true
                {
                    global.doneShot = true
                }
                else
                {
                    //NSLog("2")
                    displayPopUp(view: "boogiePopUp")
                    global.doneBoogie = true
                }
            }
        }
        //If just shot
        else if Int(global.overallTime) >= global.shotTime && global.doneShot == false
        {
            if global.isDead == true
            {
                global.doneShot = true
            }
            else
            {
                //NSLog("3")
                displayPopUp(view: "shotPopUp")
            }
            
        }
        //if just boogie
        else if Int(global.overallTime) >= global.boogieTime && global.doneBoogie == false
        {
            if global.isDead == true
            {
                global.doneBoogie = true
            }
            else
            {
                //NSLog("4")
                displayPopUp(view: "boogiePopUp")
            }
            
        }
        
    }
    
    func stormSetup()
    {
        if global.stormCount == 0
        {
            stormCounter.alpha = 0
            stormNotification.alpha = 0
        }
        
        //determine game type and setup storm settings
        if global.gameType == "short"
        {
            //global.stormTimes = [2, 10, 15, 20, 25]//TESTING
            //global.stormDamages = [1, 1, 1, 1, 1]//TESTING
            global.stormTimes = [global.stormStart, 480, 810, 1050, 1200]
            global.stormDamages = [0, 0.182, 0.263, 0.365, 0.583]
        }
        else if global.gameType == "medium"
        {
            
            global.stormTimes = [global.stormStart, 1440, 2520, 3240, 3600]
            global.stormDamages = [0, 0.0868, 0.116, 0.174, 0.347]
        }
        else if global.gameType == "long"
        {
            
            global.stormTimes = [global.stormStart, 3000, 5400, 6600, 7200]
            global.stormDamages = [0, 0.05, 0.0625, 0.125, 0.25]
        }
    }
    
    func displayPopUp(view: String)
    {
        if view == "shotPopUp"
        {
            self.view.addSubview(shotPopUp)
            shotPopUp.center = self.view.center
            global.doneShot = true
        }
        else if view == "boogiePopUp"
        {
            self.view.addSubview(boogiePopUp)
            boogiePopUp.center = self.view.center
            global.doneBoogie = true
        }
        else if view == "death"
        {
            self.view.addSubview(deathPopUp)
            deathPopUp.center = self.view.center
            global.isDead = true
            //global.gameTimer.invalidate()
            //global.checkDrinkTimer.invalidate()
            do
            {
                audioPlayer = try AVAudioPlayer(contentsOf: deathSound!)
                audioPlayer.play()
            }
            catch
            {
                
            }
        }
    }
    
    @IBAction func reviveButton(_ sender: UIButton)
    {
        global.revived = true
        global.counter = 100
        updateView()
        global.isDead = false
        self.deathPopUp.removeFromSuperview()
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
        
    }
    
    @IBAction func homeButtonDeath(_ sender: Any)
    {
        clearGameState()
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
        performSegue(withIdentifier: "segueToHome", sender: nil)
        
    }
    
}
