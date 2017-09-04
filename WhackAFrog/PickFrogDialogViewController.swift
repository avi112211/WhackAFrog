//
//  PickFrogDialogViewController.swift
//  WhackAFrog
//
//  Created by Yael on 03/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class PickFrogDialogViewController: UIViewController {
    @IBOutlet weak var theView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        theView.layer.cornerRadius = 10
    theView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeTheDialog(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

}
