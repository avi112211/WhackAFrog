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
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //coutdown timer
    var timeCounter: Int = 60
    var timer = Timer()
    
    
    
    let numberOfRows: Int = 10
    let numberOfCols: Int = 10
    var gridLayout: GridLayout!
    var isGameEnabled: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridLayout = GridLayout(numberOfCols : numberOfCols,numberOfRows : numberOfRows)
        boardCollectionView.collectionViewLayout = gridLayout
        boardCollectionView.reloadData()
        
        //start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.counter), userInfo: nil, repeats: true)
    }
    
    func counter()
    {
        timeCounter-=1
        DispatchQueue.main.async {
            self.timerLabel.text = String(self.timeCounter)
        }
        
        //timer reach zero
        if (timeCounter == 0)
        {
            timer.invalidate() //stop coutdown timer
        }
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
