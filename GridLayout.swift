//
//  GridLayout.swift
//  WhackAFrog
//
//  Created by admin on 14/08/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {

    var numberOfRows = 0
    var numberOfCols = 0
    
    init(numberOfCols: Int, numberOfRows: Int){
        super.init()
        self.numberOfCols = numberOfCols
        self.numberOfRows = numberOfRows
        self.minimumInteritemSpacing = 3
        self.minimumLineSpacing = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var itemSize: CGSize{
        get{
         
            if let collectionView = collectionView{
                let collecionViewWidth = collectionView.frame.width
                let collecionViewHeight = collectionView.frame.height
                let itemWidth = (collecionViewWidth/CGFloat(self.numberOfCols)) - self.minimumInteritemSpacing
                
                let ItemHeight = (collecionViewHeight/CGFloat(self.numberOfRows)) - self.minimumLineSpacing
                
                return CGSize(width: itemWidth, height: ItemHeight)

            }
            return CGSize(width: 100, height: 100)
        }
        set{
            super.itemSize = newValue
        }
    }
}
