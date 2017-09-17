//
//  EndGameViewController.swift
//  WhackAFrog
//
//  Created by Yael on 05/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import MapKit

class EndGameViewController: UIViewController, CLLocationManagerDelegate {

   
    @IBOutlet weak var winOrLoseMsg: UILabel!
    var nameTextField: UITextField?
    var score: Int = 0
    
    //GPS location
    var latitude:Double = -1000
    var longitude:Double = -1000
    
    let locationManager = CLLocationManager()
    
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
                if CLLocationManager.locationServicesEnabled() {
                    if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied && DataManager.showPopUp()) {
                        showLocationDisabledPopUp()
                        if CLLocationManager.locationServicesEnabled(){
                            locationManager.delegate = self
                            locationManager.desiredAccuracy = kCLLocationAccuracyBest
                            locationManager.startUpdatingLocation()
                        }
                        
                    }
                }
                else{
                    showRecordDialog()
                }
                
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
    
    func showLocationDisabledPopUp(){
        let alertController = UIAlertController(title: "Location Access Disabled", message: "In order to show your location we need your permission", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            //run your function here
            self.showRecordDialog()
        })

        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default){(action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: { action in
                    //run your function here
                    self.showRecordDialog()
                })
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func nameTextField(textField: UITextField!){
        nameTextField = textField
    }
    
  
    
    func okHandler(alert: UIAlertAction){
        
        if(nameTextField?.text == ""){
            showRecordDialog()
            return
        }
        
        //save the record to dataManager
        _ = DataManager.saveRecord(name: (nameTextField?.text)!, score: score, lng: longitude, lat: latitude)//return Bool
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
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
