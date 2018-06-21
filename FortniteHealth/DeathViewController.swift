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
    let deathSound = Bundle.main.url(forResource: "deathSound", withExtension: "mp3")

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func homeButton(_ sender: Any)
    {
        performSegue(withIdentifier: "segueToHome2", sender: nil)
    }
    
}
