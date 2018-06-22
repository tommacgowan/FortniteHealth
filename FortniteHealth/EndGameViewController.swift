//
//  EndGameViewController.swift
//  FortniteHealth
//
//  Created by Heath Rusby on 22/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit
import AVFoundation

class EndGameViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    let buttonPress = Bundle.main.url(forResource: "buttonPress", withExtension: "mp3")
    let victorySound = Bundle.main.url(forResource: "victorySoundFinal", withExtension: "mp3")

    override func viewDidLoad() {
        super.viewDidLoad()
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: victorySound!)
            audioPlayer.play()
        }
        catch
        {
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonHome(_ sender: UIButton)
    {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonPress!)
            audioPlayer.play()
        }
        catch
        {
            
        }
        performSegue(withIdentifier: "segueEndToHome", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
