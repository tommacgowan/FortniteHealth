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
    
    @IBOutlet weak var shotSwitch: UISwitch!
    @IBOutlet weak var boogieSwitch: UISwitch!
    
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
        readSwitch()
        global.stormStart = Int(arc4random_uniform(61))
        global.minDif = 120 //TESTING minimum time difference between shot or boogie
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
        readSwitch()
        global.stormStart = Int(arc4random_uniform(241))
        global.minDif = 300 //minimum time difference between shot or boogie
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
        readSwitch()
        global.stormStart = Int(arc4random_uniform(601))
        global.minDif = 600 //minimum time difference between shot or boogie
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
    
    func readSwitch()
    {
        if shotSwitch.isOn
        {
            global.hasShot = Int(arc4random_uniform(5))
        }
        else
        {
            global.hasShot = 0
        }
        if boogieSwitch.isOn
        {
            global.hasBoogie = Int(arc4random_uniform(4))
        }
        else
        {
            global.hasBoogie = 0
        }
    }
}
    
    
    

                
                

    
    
    
    
    

  


