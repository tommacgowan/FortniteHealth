//
//  DeathViewController.swift
//  FortniteHealth
//
//  Created by Heath Rusby on 21/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit
import AVFoundation

class DeathViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    let buttonPress = Bundle.main.url(forResource: "buttonPress", withExtension: "mp3")
    let deathSound = Bundle.main.url(forResource: "deathSound", withExtension: "mp3")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        global.isPause = false
        global.gameOn = false
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: deathSound!)
            audioPlayer.play()
        }
        catch
        {
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
      
    }
    
    @IBAction func reviveButton(_ sender: UIButton)
    {
        global.revived = true
        global.counter = 100
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
        performSegue(withIdentifier: "segueToGame2", sender: nil)
    }
    
    @IBAction func homeButton(_ sender: Any)
    {
        GameViewController().clearGameState()
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
        performSegue(withIdentifier: "segueToHome2", sender: nil)
    }
    
}
