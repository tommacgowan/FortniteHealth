//
//  ViewController.swift
//  FortniteHealth
//
//  Created by Tom Macgowan on 18/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController {
    
    let buttonPress = Bundle.main.url(forResource: "buttonPress", withExtension: "mp3")
    var audioPlayer = AVAudioPlayer()
    var audioSession = AVAudioSession.sharedInstance()

    
    //SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        }catch{
            
        }
        global.hasShot = Int(arc4random_uniform(5))
        global.hasBoogie = Int(arc4random_uniform(4))
        global.revived = false
        global.gameOn = false
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
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
        performSegue(withIdentifier: "segueToGame", sender: nil)
    }
    @IBAction func mediumButton(_ sender: UIButton)
    {
        global.stormStart = Int(arc4random_uniform(301))
        global.gameType = "medium"
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
        performSegue(withIdentifier: "segueToGame", sender: nil)
    }
    @IBAction func longButton(_ sender: UIButton)
    {
        global.stormStart = Int(arc4random_uniform(481))
        global.gameType = "long"
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
        performSegue(withIdentifier: "segueToGame", sender: nil)
    }
}
    
    
    

                
                

    
    
    
    
    

  


