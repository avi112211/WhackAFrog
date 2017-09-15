//
//  EndGameViewController.swift
//  WhackAFrog
//
//  Created by Yael on 05/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import MapKit

class EndGameViewController: UIViewController {

   
    @IBOutlet weak var winOrLoseMsg: UILabel!
    var nameTextField: UITextField?
    var score: Int = 0
    
    deinit {
        print("\(self) - dead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self) - alive")
        if(score <= 0){
            winOrLoseMsg.text = "YOU LOSE!\n:("
        }
            
        else{
            winOrLoseMsg.text?.append("\n Your Score:\(score)")            
            
            //check in data manager if its a new record
            if(score > DataManager.checkMinRecord()){
                showRecordDialog()
            }
        }
    }
    
    
    func showRecordDialog(){
        
        //show popup / sheet - enter name
        let alertController = UIAlertController(title: "NEW RECORD!!", message: "Enter your name", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nameTextField)
        
        //OK button
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.okHandler)
        
        //CANCEL button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
        
    }
    
    func nameTextField(textField: UITextField!){
        nameTextField = textField
    }
    
  
    
    func okHandler(alert: UIAlertAction){
        
        if(nameTextField?.text == ""){
            showRecordDialog()
            return
        }
              
        //TODO: get location
        let lng:Double = 0
        let lat:Double = 0
        
        //save the record to dataManager
        _ = DataManager.saveRecord(name: (nameTextField?.text)!, score: score, lng: lng, lat: lat)//return Bool
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            var viewControllers = navigationController.viewControllers
            viewControllers.remove(at: viewControllers.count - 2)
            
            navigationController.setViewControllers(viewControllers, animated:false)
        }
        
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
