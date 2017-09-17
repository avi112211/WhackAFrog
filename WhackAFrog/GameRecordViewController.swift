//
//  GameRecordViewController.swift
//  WhackAFrog
//
//  Created by Avi on 11/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import MapKit

class GameRecordViewController: UIViewController {

    @IBOutlet weak var recordMap: MKMapView!
    @IBOutlet weak var recordTable: UITableView!
    @IBAction func `switch`(_ sender: UISwitch) {
        if( sender.isOn == true){
            mapViewDisplay()
        }
        else{
            tableViewDisplay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(32.079, 34.775)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        recordMap.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "My home"
        annotation.subtitle = "cool home"
        recordMap.addAnnotation(annotation)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapViewDisplay(){
        recordMap.isHidden = false
        recordTable.isHidden = true

    }
    
    func tableViewDisplay(){
        recordMap.isHidden = true
        recordTable.isHidden = false
    }
}
