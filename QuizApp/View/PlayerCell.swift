//
//  PlayerCell.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 18/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var placeNumber: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeNumber.textColor = UIColor.white
        
        usernameLabel.textColor = UIColor.white
        
        pointsLabel.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
