//
//  Logic.swift
//  WhackAFrog
//
//  Created by admin on 16/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
class Logic{
    
    var board = [[Tile?]]()
    var timer = Timer()
    var score = 0
    
    init(numOfRows : Int , numOfCols : Int){
        
        board = [[Tile?]](repeating : [Tile?](repeating : nil, count: numOfCols), count: numOfRows)
        
    }
    
    func addTile(row : Int , col : Int, tile : Tile){
        board[row][col] = tile
    }
    
    func startTheGame(){
        
    }
}
