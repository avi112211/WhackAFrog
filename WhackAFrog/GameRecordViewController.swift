//
//  GameRecordViewController.swift
//  WhackAFrog
//
//  Created by Avi on 11/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GameRecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    let records = DataManager.loadRecords()
    let manager = CLLocationManager()
    var switchOn: Bool = false;
    
    @IBOutlet weak var recordMap: MKMapView!
    @IBOutlet weak var recordTable: UITableView!
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if( sender.isOn == true){
            mapMode()
        }
        else{
            recordMap.isHidden = true
            recordTable.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.recordMap.showsUserLocation = true

        addAnnotationsToMap()
        addMapTrackingButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "record", for: indexPath) as! GameRecordTableViewCell
        cell.playerName.text = records[indexPath.row].name
        cell.playerScore.text = String(records[indexPath.row].score)
        
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied && switchOn){
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp(){
        let alertController = UIAlertController(title: "Location Access Disabled", message: "In order to show your location we need your permission", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default){(action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func mapMode(){
        recordMap.isHidden = false
        recordTable.isHidden = true
        
        if CLLocationManager.locationServicesEnabled() {
            if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied && DataManager.showPopUp()) {
                showLocationDisabledPopUp()
            }
        }
    }
    
    func addAnnotationsToMap(){
        var count = 0
                
        
        for record in records{
            
            if(record.lng != -1000 && record.lat != 1000){
                count = count + 1
                let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(record.lat, record.lng)
                
                let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
                
                let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                recordMap.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = location
                annotation.title = record.name
                annotation.subtitle = String(record.score)
                recordMap.addAnnotation(annotation)
            }
        }
    }
    
    func addMapTrackingButton(){
        let image = UIImage(named: "trackme") as UIImage?
        let button   = UIButton(type: UIButtonType.system) as UIButton
        button.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(GameRecordViewController.centerMapOnUserButtonClicked), for:.touchUpInside)
        self.recordMap.addSubview(button)
    }
    
    func centerMapOnUserButtonClicked() {
        self.recordMap.setUserTrackingMode( MKUserTrackingMode.follow, animated: true)
    }
}
