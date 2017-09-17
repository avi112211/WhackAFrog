//
//  GameRecordTableViewCell.swift
//  WhackAFrog
//
//  Created by Avi on 17/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class GameRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
