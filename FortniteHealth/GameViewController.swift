//
//  GameViewController.swift
//  FortniteHealth
//
//  Created by Heath Rusby on 21/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var healthBarBackground: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var miniShield: UIButton!
    @IBOutlet weak var healthBar: UIImageView!
    @IBOutlet weak var stormNotification: UILabel!
    @IBOutlet weak var healthView: UILabel!
    
    var gameTimer = Timer()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        healthBar.setWidth(width: 2.5*CGFloat(global.counter))
        global.counter = global.startingHealth
        
        //determine game type and act accordingly
        if global.gameType == "short"
        {
            global.stormStart = Int(arc4random_uniform(2))
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(GameViewController.updateGameState)), userInfo: nil, repeats: true)
        }
        else if global.gameType == "medium"
        {
            global.stormStart = 45 + Int(arc4random_uniform(181))
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(GameViewController.updateGameState)), userInfo: nil, repeats: true)
        }
        else if global.gameType == "long"
        {
            global.stormStart = 90 + Int(arc4random_uniform(361))
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(GameViewController.updateGameState)), userInfo: nil, repeats: true)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //FUNCTIONS
    
    //miniShieldUsed
    @IBAction func miniShield(_ sender: UIButton)
    {
        if global.counter < 50 {
            if global.counter > 25 {
                global.counter = 50
            }
            else {
                global.counter = global.counter + 25
            }
        }
        healthView.text = String("\(Int(global.counter))/100")
        healthBar.setWidth(width: 2.5*CGFloat(global.counter))
    }
    
    //update game state
    @objc func updateGameState ()
    {
        global.overallTime = global.overallTime + 1
        if global.counter <= 0
        {
            clearGameState()
            performSegue(withIdentifier: "segueToDeath", sender: nil)
        }
        else if global.gameType == "short"
        {
            global.stormTimes = [global.stormStart, 480, 720, 960, 1200]
            global.stormDamages = [Double(0), Double(5), Double(2/20), Double(5/20), Double(10/20)]
    
        }
        else if global.gameType == "medium"
        {
            global.stormTimes = [global.stormStart, 1440, 2160, 2880, 3600]
            global.stormDamages = [Double(0), Double(0), Double(0), Double(0), Double(0)]
        }
        else if global.gameType == "long"
        {
            global.stormTimes = [global.stormStart, 2880, 4320, 5760, 7200]
            global.stormDamages = [Double(0), Double(0), Double(0), Double(0), Double(0)]
        }
        
        
        if Int(global.overallTime) > global.stormStart && Int(global.overallTime) <= global.stormTimes[1]
        {
            global.damageStep = global.stormDamages[1]
        }
        else if Int(global.overallTime) <= global.stormTimes[2]
        {
            global.damageStep = global.stormDamages[2]
        }
        else if Int(global.overallTime) <= global.stormTimes[3]
        {
            global.damageStep = global.stormDamages[3]
        }
        else if Int(global.overallTime) < global.stormTimes[4]
        {
            global.damageStep = global.stormDamages[4]
        }
        else if Int(global.overallTime) >= global.stormTimes[4]
        {
            //after final storm????
        }
        global.counter = global.counter - global.damageStep
        healthView.text = String("\(Int(global.counter))/100")
        healthBar.setWidth(width: 2.5*CGFloat(global.counter))
        
    }
    
    
    @IBAction func homeButton(_ sender: UIButton) {
        clearGameState()
        performSegue(withIdentifier: "segueToHome", sender: nil)
    }
    
    func clearGameState()
    {
        global.overallTime = 0
        global.counter = 100
        global.gameType = ""
        gameTimer.invalidate()
    }
    
}
