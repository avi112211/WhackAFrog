//
//  GameViewController.swift
//  WhackAFrog
//
//  Created by admin on 13/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource{
    
    //components
    @IBOutlet weak var boardCollectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //coutdown timer
    var timeCounter: Int = 60
    var timer = Timer()
    
    //board
    let numberOfRows: Int = 5
    let numberOfCols: Int = 4
    var gridLayout: GridLayout!
    
    //game controll
    var isGameEnabled: Bool = true
    var logic: Logic? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init collection view
        gridLayout = GridLayout(numberOfCols : numberOfCols,numberOfRows : numberOfRows)
        boardCollectionView.collectionViewLayout = gridLayout
        boardCollectionView.reloadData()
        
        //init logic board
        self.logic = Logic(numOfRows: numberOfRows, numOfCols: numberOfCols)
        
        
        //start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.counter), userInfo: nil, repeats: true)
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
            self.isGameEnabled = false
            timer.invalidate() //stop coutdown timer
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //for the roation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        gridLayout.invalidateLayout()
    }
    
}
