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
    var counter: Double = global.startingHealth
    var stormStart = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        healthBar.setWidth(width: 2.5*CGFloat(counter))
        
        //determine game type and act accordingly
        if global.gameType == "short"
        {
            stormStart = Int(arc4random_uniform(2))
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(GameViewController.updateGameState)), userInfo: nil, repeats: true)
        }
        else if global.gameType == "medium"
        {
            stormStart = 45 + Int(arc4random_uniform(181))
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(GameViewController.updateGameState)), userInfo: nil, repeats: true)
        }
        else if global.gameType == "long"
        {
            stormStart = 90 + Int(arc4random_uniform(361))
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
        if counter < 50 {
            if counter > 25 {
                counter = 50
            }
            else {
                counter = counter + 25
            }
        }
        healthView.text = String("\(Int(counter))/100")
        healthBar.setWidth(width: 2.5*CGFloat(counter))
    }
    
    //update game state
    @objc func updateGameState ()
    {
        global.overallTime = global.overallTime + 1
        if global.gameType == "short" && counter > 0
        {
            if global.overallTime > stormStart && global.overallTime <= 480
            {
                counter = counter - (5)
                healthView.text = String("\(Int(counter))/100")
                healthBar.setWidth(width: 2.5*CGFloat(counter))
            }
            else if global.overallTime > 480 && global.overallTime <= 720
            {
                counter = counter - (2/20)
                healthView.text = String("\(Int(counter))/100")
            }
            else if global.overallTime > 720 && global.overallTime <= 960
            {
                counter = counter - (5/20)
                healthView.text = String("\(Int(counter))/100")
            }
            else if global.overallTime > 960 && global.overallTime < 1200
            {
                counter = counter - (10/20)
                healthView.text = String("\(Int(counter))/100")
            }
            else if global.overallTime == 1200
            {
                
            }
        }
        if global.gameType == "medium" && counter > 0
        {
            if global.overallTime <= 1440
            {
                
            }
            else if global.overallTime > 1440 && global.overallTime <= 2160
            {
                
            }
            else if global.overallTime > 2160 && global.overallTime <= 2880
            {
                
            }
            else if global.overallTime > 2880 && global.overallTime < 3600
            {
                
            }
        }
        if global.gameType == "long" && counter > 0
        {
            if global.overallTime <= 2880
            {
                
            }
            else if global.overallTime > 2880 && global.overallTime <= 4320
            {
                
            }
            else if global.overallTime > 4320 && global.overallTime <= 5760
            {
                
            }
            else if global.overallTime > 5760 && global.overallTime < 7200
            {
                
            }
        }
        if counter == 0
        {
            clearGameState()
            performSegue(withIdentifier: "segueToDeath", sender: nil)
        }
    }
    
    
    @IBAction func homeButton(_ sender: UIButton) {
        clearGameState()
        performSegue(withIdentifier: "segueToHome", sender: nil)
    }
    
    func clearGameState()
    {
        global.overallTime = 0
        counter = 100
        global.gameType = ""
        gameTimer.invalidate()
    }
    
}
