//
//  QuestionView.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 20/04/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    
    let questionLabel = UILabel()
    let buttonA = UIButton()
    let buttonB = UIButton()
    let buttonC = UIButton()
    let buttonD = UIButton()
    var buttons = [UIButton]()
    let progressLabel1 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    private func render() {
        self.backgroundColor = .black
        setUpElements()
        setUpConstraints()
    }
    
    private func setUpElements(){
        self.addSubview(questionLabel)
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.minimumScaleFactor = 0.5
        questionLabel.textAlignment = .center
        questionLabel.backgroundColor = .black
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.minimumScaleFactor = 0.5
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 24.0)
        questionLabel.textColor = UIColor.white
        
        self.addSubview(buttonA)
        buttonA.setTitleColor(.black, for: .normal)
        buttonA.tag = 0
        buttonA.setTitle("", for: .normal)
        buttonA.backgroundColor = .gray
        buttonA.layer.cornerRadius = 20
        buttonA.layer.borderWidth = 1
        
        self.addSubview(buttonB)
        buttonB.setTitleColor(.black, for: .normal)
        buttonB.tag = 1
        buttonB.setTitle("", for: .normal)
        buttonB.backgroundColor = .gray
        buttonB.layer.cornerRadius = 20
        buttonB.layer.borderWidth = 1
        
        self.addSubview(buttonC)
        buttonC.setTitleColor(.black, for: .normal)
        buttonC.tag = 2
        buttonC.setTitle("", for: .normal)
        buttonC.backgroundColor = .gray
        buttonC.layer.cornerRadius = 20
        buttonC.layer.borderWidth = 1
        
        self.addSubview(buttonD)
        buttonD.setTitleColor(.black, for: .normal)
        buttonD.tag = 3
        buttonD.setTitle("", for: .normal)
        buttonD.backgroundColor = .gray
        buttonD.layer.cornerRadius = 20
        buttonD.layer.borderWidth = 1
        
        buttons.append(buttonA)
        buttons.append(buttonB)
        buttons.append(buttonC)
        buttons.append(buttonD)
    }
    
    private func setUpConstraints(){
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        questionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 77).isActive = true
        questionLabel.numberOfLines = 0
        questionLabel.adjustsFontSizeToFitWidth = true
        
        buttonA.translatesAutoresizingMaskIntoConstraints = false
        buttonA.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 32).isActive = true
        buttonA.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        buttonA.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        buttonA.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        buttonB.translatesAutoresizingMaskIntoConstraints = false
        buttonB.topAnchor.constraint(equalTo: self.buttonA.bottomAnchor, constant: 13).isActive = true
        buttonB.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        buttonB.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        buttonB.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        buttonC.translatesAutoresizingMaskIntoConstraints = false
        buttonC.topAnchor.constraint(equalTo: self.buttonB.bottomAnchor, constant: 13).isActive = true
        buttonC.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        buttonC.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        buttonC.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        buttonD.translatesAutoresizingMaskIntoConstraints = false
        buttonD.topAnchor.constraint(equalTo: self.buttonC.bottomAnchor, constant: 13).isActive = true
        buttonD.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        buttonD.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        buttonD.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}

