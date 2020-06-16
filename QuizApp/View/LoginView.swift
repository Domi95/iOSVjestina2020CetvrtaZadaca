//
//  LoginView.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 29/04/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class LoginView : UIView {
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let logInButton = UIButton()
    let quizTitle = UILabel()
    
    var rightAnchorConstraint: NSLayoutConstraint?
    var leftAnchorConstraint: NSLayoutConstraint?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        

    }
    
    private func render() {
        backgroundColor = .black
        setUpElements()
        setUpConstraints()
    }
    
    func setUpElements(){
        self.addSubview(usernameTextField)
        usernameTextField.layer.cornerRadius = 20
        usernameTextField.clipsToBounds = true
        usernameTextField.placeholder = "Username"
        usernameTextField.backgroundColor = .darkGray
        usernameTextField.text = "username"
        
        self.addSubview(passwordTextField)
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.clipsToBounds = true
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .darkGray
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text = "password"

        self.addSubview(logInButton)
        logInButton.layer.cornerRadius = 20
        logInButton.clipsToBounds = true
        logInButton.setTitle("Log in", for: .normal)
        logInButton.backgroundColor = .gray
        
        self.addSubview(quizTitle)
        quizTitle.layer.cornerRadius = 20
        quizTitle.clipsToBounds = true
        quizTitle.backgroundColor = .black
        quizTitle.adjustsFontSizeToFitWidth = true
        quizTitle.minimumScaleFactor = 0.5
        quizTitle.textAlignment = .center
        quizTitle.text = "PopQuiz"
        quizTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 32.0)
        quizTitle.textColor = UIColor.white
    }
    
    func setUpConstraints(){
        quizTitle.translatesAutoresizingMaskIntoConstraints = false
        quizTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        quizTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        quizTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        quizTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        quizTitle.numberOfLines = 0
        quizTitle.adjustsFontSizeToFitWidth = true
        
       //usernameTextField.translatesAutoresizingMaskIntoConstraints = false
       // usernameTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
//        usernameTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
//        usernameTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
//        usernameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        usernameTextField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 13).isActive = true
//        passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
//        passwordTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
//        passwordTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
//        logInButton.translatesAutoresizingMaskIntoConstraints = false
//        logInButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 13).isActive = true
//        logInButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
//        logInButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
//        logInButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
