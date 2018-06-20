//
//  DeathViewController.swift
//  FortniteHealth
//
//  Created by Heath Rusby on 21/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit

class DeathViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
