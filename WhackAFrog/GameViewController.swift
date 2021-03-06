//
//  GameViewController.swift
//  WhackAFrog
//
//  Created by admin on 13/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import CoreLocation

class GameViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, CLLocationManagerDelegate{
    
    //components
    @IBOutlet weak var boardCollectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!	
    @IBOutlet weak var scoreLabel: UILabel!
    
    //coutdown timer
    var timeCounter: Int = 0
    var timer:Timer!
    
    //board
    let numberOfRows: Int = 5
    let numberOfCols: Int = 4
    var gridLayout: GridLayout!
    
    //GPS location
    var latitude:Double = -1000
    var longitude:Double = -1000
    
    //game controll
    var isGameEnabled: Bool!
    var logic: Logic!
    
    deinit {
        print("\(self) - dead")
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        resetBoard()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        print("\(self) - alive")
            }
    
    override func viewWillAppear(_ animated: Bool) {
        //start timer
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.counter), userInfo: nil, repeats: true)
        
        logic?.startTheGame()
    }
    
    override func viewDidDisappear(_ animated: Bool){
        timer.invalidate()
        logic?.frogTimer.invalidate()
        logic?.enemyTimer.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    
    func resetBoard(){
        
        timeCounter = 15
        timer = Timer()
        isGameEnabled = true
        
        //init frog pic from user detaults
        if let savedImage:UIImage = DataManager.loadImage(fromFile: DataManager.pictureFileName) {
            //pickedImageButton.setImage(savedImage, for: .normal)
            Tile.frogImage = savedImage
        }
        else{
            Tile.frogImage = UIImage(named: "frogIcon")!
        }

        
        //init collection view
        gridLayout = GridLayout(numberOfCols : numberOfCols,numberOfRows : numberOfRows)
        boardCollectionView.collectionViewLayout = gridLayout
        boardCollectionView.reloadData()
        
        //init logic board
        scoreLabel.text = String(0)
        self.logic = Logic(numOfRows: numberOfRows, numOfCols: numberOfCols, scoreLabel : scoreLabel)
        timerLabel.text = String(timeCounter)
        
        
    }

    
    //applies every second
    func counter()
    {
        timeCounter-=1
        DispatchQueue.main.async {
            self.timerLabel.text = String(self.timeCounter)
        }
        
        //timer reach zero
        if (timeCounter == 0)
        {
            endGame()
            timer.invalidate() //stop coutdown timer
            
        }
    }
    
    func endGame(){
        self.isGameEnabled = false
        self.logic?.isGameEnabled = false
        timer.invalidate()
        logic?.frogTimer.invalidate()
        logic?.enemyTimer.invalidate()
        locationManager.stopUpdatingLocation()
        
        performSegue(withIdentifier: "endGame", sender: self)
        
        if let navigationController = self.navigationController {
            var viewControllers = navigationController.viewControllers
            viewControllers.remove(at: viewControllers.count - 2)
            
            navigationController.setViewControllers(viewControllers, animated:false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! EndGameViewController
        
        destVC.score = Int(scoreLabel.text!)!
        destVC.longitude = longitude
        destVC.latitude = latitude
    }
    
    
    //  collection view init functions
    
    //number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfCols
    }
   
    //init tiles
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tile = collectionView.dequeueReusableCell(withReuseIdentifier: "Tile", for: indexPath) as! Tile
        
        //logic - UI match
        logic?.addTile(row: indexPath.row, col : indexPath.section, tile: tile)
        
        return tile
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfRows
    }
    
    //for the rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        gridLayout.invalidateLayout()
    }
    
    //cell selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        logic?.click(row: indexPath.row, col: indexPath.section)
        if(Int(scoreLabel.text!)! < 0){
            endGame()
            timer.invalidate() //stop coutdown timer
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
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
