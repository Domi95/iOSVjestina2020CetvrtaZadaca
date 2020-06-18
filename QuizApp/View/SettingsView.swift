//
//  SettingsView.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 19/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class SettingsView: UIView {
    let usernameLabel = UILabel()
    let logoutButton = UIButton()
    let logedInUsernameLabel = UILabel()
    let loggingService = LoggingService()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    func render(){
        self.backgroundColor = myColor.backgroundColor
        setUpElements()
        setUpConstraints()
    }
    
    func setUpElements(){
        addSubview(logoutButton)
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.layer.cornerRadius = 20
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        
        addSubview(usernameLabel)
        usernameLabel.text = "USERNAME"
        usernameLabel.font = UIFont(name:"HelveticaNeue", size: 12.0)
        usernameLabel.textColor = UIColor.white
        
        addSubview(logedInUsernameLabel)
        let username = loggingService.returnLogedInUsername()
        logedInUsernameLabel.text = username
        logedInUsernameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        logedInUsernameLabel.textColor = UIColor.white
    }
    
    func setUpConstraints(){
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 113).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 124).isActive = true
        
        logedInUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        logedInUsernameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4).isActive = true
        logedInUsernameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        logedInUsernameLabel.heightAnchor.constraint(equalToConstant: 47).isActive = true
        logedInUsernameLabel.widthAnchor.constraint(equalToConstant: 243).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
