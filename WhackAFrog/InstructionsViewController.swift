//
//  InstructionsViewController.swift
//  WhackAFrog
//
//  Created by admin on 13/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var centerXDialogConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickedPic: UIImageView!
    @IBOutlet weak var picturePicker: UIPickerView!
    
    static let picturs = ["frogIcon", "green-leaf-md"]
    static let key:String = "pickedPic"
    var currentPic:String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        centerXDialogConstraint.constant = 400
        currentPic = InstructionsViewController.picturs[0]

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //4 functions for the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currentPic = InstructionsViewController.picturs[row]
        return currentPic
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return InstructionsViewController.picturs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentPic = InstructionsViewController.picturs[row]
        pickedPic.image = UIImage(named: currentPic)
    }
    //
    
    
    @IBAction func showDialog(_ sender: Any) {
        centerXDialogConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
 
   
    @IBAction func closeDialogWithAnswer(_ sender: Any) {
        centerXDialogConstraint.constant = 400
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        //TODO: add check what pic the user picked and save it
        UserDefaults.standard.setValue(currentPic, forKey: InstructionsViewController.key)
    }
   
    @IBAction func closeDialogNoAnswer(_ sender: Any) {
        centerXDialogConstraint.constant = 400
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })

    }
}
