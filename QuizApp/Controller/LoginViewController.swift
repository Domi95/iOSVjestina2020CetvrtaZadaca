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
    }
    
    func render(){
        self.navigationController?.isNavigationBarHidden = true
        setUplogInView()
        setUpButtonsActions()
        activateAnimation1()
    }
    
    func activateAnimation1(){
        logInView.quizTitle.flash()
        UIView.animate(withDuration: 1, animations: {
            self.logInView.quizTitle.transform = CGAffineTransform(scaleX: 1.9, y: 1.9) //Scale label area
            self.logInView.usernameTextField.transform = CGAffineTransform(translationX: 311, y: 0)
            self.activateAnimation2()
            })
    }
    
    func activateAnimation2(){
        UIView.animate(withDuration: 0.7,delay: 0.3,  animations: {
            self.logInView.passwordTextField.transform =
            self.logInView.passwordTextField.transform.translatedBy(x: 311, y: 0)
            self.activateAnimation3()
        })
    }

    func activateAnimation3(){
        UIView.animate(withDuration: 0.7, delay: 0.6, animations: {
               self.logInView.logInButton.transform =
               self.logInView.logInButton.transform.translatedBy(x: 311, y: 0)
           })
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
        flash.duration = 3
        flash.fromValue = 0.1
        flash.toValue = 1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
}
