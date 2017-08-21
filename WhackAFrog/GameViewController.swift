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
    var timeCounter: Int = 30
    var timer = Timer()
    
    //board
    let numberOfRows: Int = 5
    let numberOfCols: Int = 4
    var gridLayout: GridLayout!
    
    //game controll
    var isGameEnabled: Bool = true
    var logic: Logic? = nil
    
    deinit {
        print("\(self) - dead")
    }
    
    override func viewDidLoad() {
        //boardCollectionView.allowsSelection = true
        super.viewDidLoad()
        print("\(self) - alive")
        //init collection view
        gridLayout = GridLayout(numberOfCols : numberOfCols,numberOfRows : numberOfRows)
        boardCollectionView.collectionViewLayout = gridLayout
        boardCollectionView.reloadData()
        
        
        //init logic board
        self.logic = Logic(numOfRows: numberOfRows, numOfCols: numberOfCols, scoreLabel : scoreLabel)
        timerLabel.text = String(timeCounter)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.counter), userInfo: nil, repeats: true)
        
        logic?.startTheGame()
    }
    
    override func viewDidDisappear(_ animated: Bool){
        timer.invalidate()
        logic?.frogTimer.invalidate()
        logic?.enemyTimer.invalidate()
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

        
        performSegue(withIdentifier: "endGame", sender: self)
        
        if let navigationController = self.navigationController {
            var viewControllers = navigationController.viewControllers
            viewControllers.remove(at: viewControllers.count - 2)
            
            navigationController.setViewControllers(viewControllers, animated:false)
        }
        
        
//        let thisConrollView = storyboard?.instantiateViewController(withIdentifier: "EndGameViewController") as! EndGameViewController
//        thisConrollView.stringPassed = "LOSE"
//        navigationController?.pushViewController(thisConrollView, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! EndGameViewController
        
        destVC.score = Int(scoreLabel.text!)!
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
