//
//  ViewController.swift
//  WhackAFrog
//
//  Created by admin on 13/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startTheGame(_ sender: UIButton) {
        //go to GameUIView
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
    
    @IBAction func openInstruction(_ sender: UIButton) {
        //show the Instructions
        performSegue(withIdentifier: "instructionsSegue", sender: self)
    }
}

