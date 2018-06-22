//
//  EndGameViewController.swift
//  FortniteHealth
//
//  Created by Heath Rusby on 22/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonHome(_ sender: UIButton) {
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
