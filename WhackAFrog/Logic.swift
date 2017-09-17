//
//  Logic.swift
//  WhackAFrog
//
//  Created by admin on 16/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class Logic{
    
    var board = [[Tile?]]()
    
    var numOfRows = 0
    var numOfCols = 0
    
    var frogTimer = Timer()
    var enemyTimer = Timer()
    var score = 0
    var scoreLabel : UILabel? = nil
    
    var frogX = -1
    var frogY = -1
    
    var enemyX = -1
    var enemyY = -1
    
    var isGameEnabled: Bool = true
    
    let hitPoint = 5
    let missPoint = -10
    
    //creat board rowsXcols with nil value
    init(numOfRows : Int , numOfCols : Int, scoreLabel : UILabel){
        
        self.numOfRows = numOfRows
        self.numOfCols = numOfCols
        
        board = [[Tile?]](repeating : [Tile?](repeating : nil, count: numOfRows), count: numOfCols)
        
        self.scoreLabel = scoreLabel
    }
    
    
    func addTile(row : Int , col : Int, tile : Tile){
        board[row][col] = tile
    }
    
    func startTheGame(){
        
        //timer for frogs
        frogTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Logic.putFrog), userInfo: nil, repeats: true)
        
        //timer for enemies
        enemyTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(Logic.putEnemy), userInfo: nil, repeats: true)
    }

    
    @objc func putFrog(){
        //timer reach zero
        if (!isGameEnabled)
        {
            frogTimer.invalidate() //stop coutdown timer
        }
        
        //search an empty tile
        var x = Int(arc4random_uniform(UInt32(self.numOfCols)))
        var y = Int(arc4random_uniform(UInt32(self.numOfRows)))
        
        while((x == enemyX && y == enemyY)||(x == frogX && y == frogY)){
            x = Int(arc4random_uniform(UInt32(self.numOfCols)))
            y = Int(arc4random_uniform(UInt32(self.numOfRows)))

        }
        
        //found an empty tile
        //delete the old frog
        if(frogX != -1){
            board[frogX][frogY]?.setValue(val : 0)
        }
        frogX = x
        frogY = y
        
        //make a new frog
        board[x][y]?.setValue(val : 1)         
    }
    
    @objc func putEnemy(){
         //timer reach zero
        if (!isGameEnabled)
        {
            enemyTimer.invalidate() //stop coutdown timer
        }
        
        //search an empty tile
        var x = Int(arc4random_uniform(UInt32(self.numOfCols)))
        var y = Int(arc4random_uniform(UInt32(self.numOfRows)))
        
        while((x == enemyX && y == enemyY)||(x == frogX && y == frogY)){
            x = Int(arc4random_uniform(UInt32(self.numOfCols)))
            y = Int(arc4random_uniform(UInt32(self.numOfRows)))
            
        }
        
        //found an empty tile
        //delete the old enemy
        if enemyX != -1{
            board[enemyX][enemyY]?.setValue(val : 0)
        }
        enemyX = x
        enemyY = y
        
        //make a new enemy
        board[x][y]?.setValue(val : -1)
    }
    
    func click(row : Int , col : Int){
        
        let tile = board[row][col]
        
        if(tile?.value == -1){
           score  += missPoint
        }
        else if(tile?.value == 1){
            score += hitPoint
        }
        tile?.setValue(val: 0)
        scoreLabel?.text = String(score)
    }
}







