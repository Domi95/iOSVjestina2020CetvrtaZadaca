//
//  StartQuizView.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 08/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class StartQuizView: UIView {
    let quizTitle = UILabel()
    var quizImage = UIImageView()
    let startQuizButton = UIButton()
    let quizDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    private func render() {
        self.backgroundColor = .darkGray
        setUpElements()
        configureConstraints()
    }
    
    func configureConstraints(){
        self.layer.cornerRadius = 20
        
        quizTitle.translatesAutoresizingMaskIntoConstraints = false
        quizTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 23).isActive = true
        quizTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        quizTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        quizTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        quizDescription.translatesAutoresizingMaskIntoConstraints = false
        quizDescription.topAnchor.constraint(equalTo: quizTitle.bottomAnchor, constant: 18).isActive = true
        quizDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        quizDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        quizDescription.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        quizImage.bottomAnchor.constraint(equalTo: startQuizButton.topAnchor, constant: -20).isActive = true
        quizImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        quizImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        quizImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        startQuizButton.translatesAutoresizingMaskIntoConstraints = false
        startQuizButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -26).isActive = true
        startQuizButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        startQuizButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        startQuizButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setUpElements(){
        self.addSubview(quizTitle)
        self.addSubview(quizImage)
        self.addSubview(quizDescription)
        self.addSubview(startQuizButton)
        
        quizTitle.adjustsFontSizeToFitWidth = true
        quizTitle.textAlignment = .center
        quizTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 32.0)
        quizTitle.textColor = UIColor.white
        
        quizDescription.adjustsFontSizeToFitWidth = true
        quizDescription.textAlignment = .center
        quizDescription.font = UIFont(name:"HelveticaNeue", size: 18.0)
        quizDescription.textColor = UIColor.white
        
        startQuizButton.backgroundColor = .white
        startQuizButton.setTitleColor(.black, for: .normal)
        startQuizButton.setTitle("Start Quiz", for: .normal)
        startQuizButton.backgroundColor = .gray
        startQuizButton.layer.cornerRadius = 20
        
        quizImage.layer.cornerRadius = 20
        quizImage.layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
