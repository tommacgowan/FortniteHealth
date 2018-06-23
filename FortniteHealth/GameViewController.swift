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
        global.isPause = false
        healthBar.setWidth(width: 2.5*CGFloat(global.counter))
        global.counter = global.startingHealth
        miniShield.isEnabled = true
        bigShield.isEnabled = true
        chugShield.isEnabled = true
        miniShield.alpha = 1
        bigShield.alpha = 1
        chugShield.alpha = 1
        if global.stormCount == 0
        {
            stormCounter.alpha = 0
            stormNotification.alpha = 0
        }
        
        //determine game type and setup storm settings
        if global.gameType == "short"
        {
           //setup for testing purposes atm
            global.stormTimes = [global.stormStart, 10/*480*/, 20/*720*/, 30/*960*/, 200/*1200*/]
            global.stormDamages = [0, 1/*0.01*/, 1/*0.02*/, 2/*0.05*/, 2/*0.1*/]
        }
        else if global.gameType == "medium"
        {
            
            global.stormTimes = [global.stormStart, 1440, 2160, 2880, 3600]
            global.stormDamages = [0, 0.0365, 0.0731, 0.183, 0.365]
        }
        else if global.gameType == "long"
        {
            
            global.stormTimes = [global.stormStart, 2880, 4320, 5760, 7200]
            global.stormDamages = [0, 0.0256, 0.512, 0.128, 0.256]
        }
        
        //Decides when shot occurs
        if global.revived == false
        {
            if global.hasShot == 1
            {
                global.shotTime = Int(arc4random_uniform(UInt32(global.stormTimes[4])))
                global.doneShot = false
                NSLog("Has shot at %d",global.shotTime)
            }
            else
            {
                NSLog("No Shot this time")
            }
        }
        
        if global.hasBoogie == 1
        {
            global.boogieTime = Int(arc4random_uniform(UInt32(global.stormTimes[4])))
            global.doneBoogie = false
        }
        
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
    
    //update game state
    @objc func updateGameState ()
    {
       
        global.overallTime = global.overallTime + 1
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
            global.damageStep = global.stormDamages[2]
            global.counter = global.counter - global.damageStep
            updateView()
        }
        else if Int(global.overallTime) <= global.stormTimes[3]
        {
            global.stormCount = 3
            global.damageStep = global.stormDamages[3]
            global.counter = global.counter - global.damageStep
            updateView()
        }
        else if Int(global.overallTime) < global.stormTimes[4]
        {
            global.stormCount = 4
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
            self.shotPopUp.removeFromSuperview()
            if miniShield.isEnabled == false
            {
                audioPlayer.stop()
            }
            global.gameTimer.invalidate()
            global.checkDrinkTimer.invalidate()
            performSegue(withIdentifier: "segueToDeath", sender: nil)
        }
        
        //Check for shot
        if Int(global.overallTime) >= global.shotTime && global.doneShot == false
        {
            self.view.addSubview(shotPopUp)
            shotPopUp.center = self.view.center
            global.doneShot = true
        }
        
        //Check for boogie
        if Int(global.overallTime) >= global.boogieTime && global.doneBoogie == false
        {
            self.view.addSubview(boogiePopUp)
            shotPopUp.center = self.view.center
            global.doneShot = true
        }
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
    
    func clearGameState()
    {
        global.drinking = false
        global.doneShot = true
        global.drinkType = ""
        global.gameType = ""
        global.overallTime = 0
        global.counter = 100
        global.gameType = ""
        global.stormCount = 0
        global.gameTimer.invalidate()
        global.checkDrinkTimer.invalidate()
        global.revived = false
    }
}
