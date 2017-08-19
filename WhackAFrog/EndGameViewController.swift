//
//  EndGameViewController.swift
//  WhackAFrog
//
//  Created by admin on 16/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet weak var winOrLoseMsg: UILabel!
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(score <= 0){
            winOrLoseMsg.text = "YOU LOSE!\n:("
        }
        
        else{
            winOrLoseMsg.text?.append("\n Your Score:\(score)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backTomain(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
   
    @IBAction func playAgain(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    //change the navigator back buttun to home screen
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if (parent == nil) {
            if let navigationController = self.navigationController {
                var viewControllers = navigationController.viewControllers
                while (viewControllers.count > 2)
                {
                    viewControllers.remove(at: viewControllers.count - 2)
                    
                }
                navigationController.setViewControllers(viewControllers, animated:false)
            }
        }
    }
    
}

