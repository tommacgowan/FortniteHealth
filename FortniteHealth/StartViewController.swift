//
//  ViewController.swift
//  FortniteHealth
//
//  Created by Tom Macgowan on 18/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    
    //SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        global.hasShot = Int(arc4random_uniform(5))
        global.revived = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shortButton(_ sender: UIButton)
    {
        global.stormStart = Int(arc4random_uniform(4/*121*/))
        global.gameType = "short"
        performSegue(withIdentifier: "segueToGame", sender: nil)
    }
    @IBAction func mediumButton(_ sender: UIButton)
    {
        global.gameType = "medium"
        performSegue(withIdentifier: "segueToGame", sender: nil)
        global.stormStart = Int(arc4random_uniform(301))
    }
    @IBAction func longButton(_ sender: UIButton)
    {
        global.stormStart = Int(arc4random_uniform(481))
        global.gameType = "long"
        performSegue(withIdentifier: "segueToGame", sender: nil)
    }
}
    
    
    

                
                

    
    
    
    
    

  


