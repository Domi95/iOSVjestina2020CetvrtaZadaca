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
    var timer = Timer()
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    init(win: UIWindow){
        super.init(nibName: nil, bundle: nil)
        window = win
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(){
        self.navigationController?.isNavigationBarHidden = true
        setUplogInView()
        setUpButtonsActions()
        activatePresentAnimation1()
        view.backgroundColor = .black
    }
    
    func activatePresentAnimation1(){
        logInView.quizTitle.flash()
        UIView.animate(withDuration: 0.8, animations: {
            self.logInView.quizTitle.transform = CGAffineTransform(scaleX: 1.9, y: 1.9) //Scale label area
            self.logInView.usernameTextField.transform = CGAffineTransform(translationX: 351, y: 0)
            self.activatePresentAnimation2()
        })
    }
    
    func activatePresentAnimation2(){
        UIView.animate(withDuration: 0.6,delay: 0.2,  animations: {
            self.logInView.passwordTextField.transform =
                self.logInView.passwordTextField.transform.translatedBy(x: 351, y: 0)
            self.activatePresentAnimation3()
        })
    }
    
    func activatePresentAnimation3(){
        UIView.animate(withDuration: 0.6, delay: 0.4, animations: {
            self.logInView.logInButton.transform =
                self.logInView.logInButton.transform.translatedBy(x: 351, y: 0)
        })
    }
    
    func activateHideAnimation1(){
        UIView.animate(withDuration: 0.6, animations: {
            self.logInView.quizTitle.transform = CGAffineTransform(translationX: 0, y: -200)
        })
        activateHideAnimation2()
    }
    
    func activateHideAnimation2(){
        UIView.animate(withDuration: 0.6, delay: 0.2, animations: {
            self.logInView.usernameTextField.transform = self.logInView.usernameTextField.transform.translatedBy(x: 0, y: -400)
            
        })
        activateHideAnimation3()
    }
    
    func activateHideAnimation3(){
        UIView.animate(withDuration: 0.6, delay: 0.4, animations: {
            self.logInView.passwordTextField.transform = self.logInView.passwordTextField.transform.translatedBy(x: 0, y: -450)
        })
        activateHideAnimation4()
    }
    
    func activateHideAnimation4(){
        UIView.animate(withDuration: 0.6, delay: 0.6, animations: {
            self.logInView.logInButton.transform = self.logInView.logInButton.transform.translatedBy(x: 0, y: -500)
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
                    self.logInView.errorLabel.isHidden = true
                    self.activateHideAnimation1()
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(self.nextViewController), userInfo:nil, repeats: false)
                } else {
                    self.logInView.errorLabel.isHidden = false
                }
            }
        })
    }
    
    @objc func nextViewController(){
        let customTabBarController = CustomTabBarController(win: window!)
        window?.rootViewController = customTabBarController
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
        flash.duration = 2
        flash.fromValue = 0
        flash.toValue = 1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
}
