//
//  GameViewController.swift
//  WhackAFrog
//
//  Created by admin on 13/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource{
    
    @IBOutlet weak var boardCollectionView: UICollectionView!

    let numberOfRows = 5
    let numberOfCols = 4
    var gridLayout: GridLayout!
    var isGameEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridLayout = GridLayout(numberOfCols : numberOfCols,numberOfRows : numberOfRows)
        boardCollectionView.collectionViewLayout = gridLayout
        boardCollectionView.reloadData()
        
        //let screenSize = UIScreen.main.bounds
        //let screenWidth = screenSize.width
        //let screenHeight = screenSize.height
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfCols
    }
   
    //init tiles
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tile = collectionView.dequeueReusableCell(withReuseIdentifier: "Tile", for: indexPath) as! Tile
    
        //if let image = UIImage(named: "frogIcon"){
       // tile.myButton.setImage(image, for: .normal)
        //}
        
        return tile
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfRows
    }
    
    //for the roation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        gridLayout.invalidateLayout()
    }
    
}
