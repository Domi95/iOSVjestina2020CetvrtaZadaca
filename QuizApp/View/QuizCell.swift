//
//  QuizCell.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 06/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import UIKit

class QuizCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var quizTitle: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellQuizDescription: UILabel!
    
    @IBOutlet weak var imageLevel1: UIImageView!
    @IBOutlet weak var imageLevel2: UIImageView!
    @IBOutlet weak var imageLevel3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = myColor.backgroundColor
        quizTitle.adjustsFontSizeToFitWidth = true
        quizTitle.numberOfLines = 1
        quizTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 24.0)
        
        cellQuizDescription.adjustsFontSizeToFitWidth = true
        cellQuizDescription.numberOfLines = 0
        cellQuizDescription.font = UIFont(name:"HelveticaNeue", size: 14.0)
        
        cellView.layer.cornerRadius = 20
        cellView.backgroundColor = myColor.buttonColor1
        
        cellImage.layer.cornerRadius = 20
        cellImage.layer.masksToBounds = true
        
        imageLevel1.tintColor = .lightGray
        imageLevel2.tintColor = .lightGray
        imageLevel3.tintColor = .lightGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
