//
//  Tile.swift
//  WhackAFrog
//
//  Created by admin on 13/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class Tile: UICollectionViewCell {
    
    @IBOutlet weak var hole: UIImageView!
    
    static var frogImage = UIImage(named: "frogIcon")//1
    let enemyImage = UIImage(named: "badFrog")//-1
    //let holeImage = nil      //0
    
    var value : Int = 0

    
    
    
    func setValue(val : Int){
        
        if val == 0{
            hole.image = nil
        }
        else if val == 1{
            hole.image = Tile.frogImage
        }
        else if val == -1{
            hole.image = enemyImage
        }
        
        self.value = val
        
    }
}
