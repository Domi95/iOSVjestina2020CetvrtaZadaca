//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 29/04/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    let logInView = LoginView()
    let loggingService = LoggingService()
    let quizService = QuizService()
    let quizzesMenuViewController = QuizzesMenuViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isUserLogedIn()
        setUpAnimation()
    }
    
    func render(){
        self.navigationController?.isNavigationBarHidden = true
        setUplogInView()
        setUpButtonsActions()
        setUpAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setUpAnimation(){
        logInView.quizTitle.flash()
        UIView.animate(withDuration: 2.7) {
            self.logInView.quizTitle.transform = CGAffineTransform(scaleX: 1.9, y: 1.9) //Scale label area
            self.logInView.usernameTextField.frame = CGRect(x: 13, y: 200, width: 311, height: 44)
            self.logInView.passwordTextField.frame = CGRect(x: 13, y: 256, width: 311, height: 44)
            self.logInView.logInButton.frame = CGRect(x: 13, y: 312, width: 311, height: 44)
        }
    }
    
    
    @objc func logInPressed(){
                let defaults = UserDefaults.standard
                defaults.set(logInView.usernameTextField.text, forKey: "Username")
                guard let username = logInView.usernameTextField.text?.lowercased() else {
                    return
                }
                guard let password = logInView.passwordTextField.text?.lowercased() else {
                    return
                }
                loggingService.makeURLRequest(username: username, password: password, completion: { (status) in
                    DispatchQueue.main.async {
                        if status == true {
                            self.navigationController?.pushViewController(self.quizzesMenuViewController, animated: true)
                        } else {
                            print("ne otvaram ekran")
                        }
                    }
                })
    }
    
    func isUserLogedIn(){
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "Token") == nil && defaults.object(forKey: "Id") == nil {
            render()
        } else {
            self.navigationController?.pushViewController(quizzesMenuViewController, animated: true)
        }
    }
    
    func setUpButtonsActions(){
        logInView.logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
    }
    
    func setUplogInView(){
        view.addSubview(logInView)
        logInView.translatesAutoresizingMaskIntoConstraints = false
        logInView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        logInView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        logInView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        logInView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
}

extension UILabel {
    func flash(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 5
        flash.fromValue = 0.1
        flash.toValue = 1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
}
