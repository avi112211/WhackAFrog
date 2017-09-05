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
    
    static var frogImage:UIImage = UIImage(named: "frogIcon")!//1
    static let enemyImage:UIImage = UIImage(named: "badFrog")!//-1
    //let holeImage = nil      //0
    
    var value : Int = 0

    
    
    
    func setValue(val : Int){
        
        if val == 0{
            if(self.value == 1){
                UIView.animate(withDuration: 0.1, animations: ({
                    self.hole.transform = CGAffineTransform(rotationAngle: 0)
                }))
            }
            hole.image = nil
        }
        else if val == 1{
            
            hole.image = Tile.frogImage
            //animate the frog
            UIView.animate(withDuration: 1.0, animations: ({
                self.hole.transform = CGAffineTransform(rotationAngle: 360)
            }))

        }
        else if val == -1{
            hole.image = Tile.enemyImage
        }
        
        self.value = val
        
    }
}
