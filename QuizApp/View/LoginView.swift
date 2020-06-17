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
    let errorLabel = UILabel()
    
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
        usernameTextField.text = "2016027"
        
        self.addSubview(passwordTextField)
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.clipsToBounds = true
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .darkGray
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text = "2016027"

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
        
        self.addSubview(errorLabel)
        errorLabel.layer.cornerRadius = 20
        errorLabel.clipsToBounds = true
        errorLabel.backgroundColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.minimumScaleFactor = 0.5
        errorLabel.textAlignment = .center
        errorLabel.text = "Wrong username or password"
        errorLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
        errorLabel.textColor = UIColor.white
        errorLabel.isHidden = true
    }
    
    func setUpConstraints(){
        quizTitle.translatesAutoresizingMaskIntoConstraints = false
        quizTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        quizTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        quizTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        quizTitle.heightAnchor.constraint(equalToConstant: 27).isActive = true
        quizTitle.numberOfLines = 0
        quizTitle.adjustsFontSizeToFitWidth = true
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -351).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150).isActive = true
        usernameTextField.widthAnchor.constraint(equalToConstant: 311).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -351).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 311).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -351).isActive = true
        logInButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 311).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100).isActive = true
        errorLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
