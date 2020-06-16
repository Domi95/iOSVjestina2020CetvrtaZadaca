//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 16/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    var settingsView = SettingsView()
    let loggingService = LoggingService()
    let loginViewController = LoginViewController()
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        render()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingsView.setUpElements()
      }
    
    @objc func logoutPressed(){
        loggingService.logOutUser()
        rootViewControllerGlobal.setUpNavigationControllers()
    }
    
    private func render(){
        view.backgroundColor = .black
        setUpConstraints()
        setUpButtonsActions()
    }
    
    private func setUpButtonsActions(){
           settingsView.logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
       }
    
    private func setUpConstraints(){
           view.addSubview(settingsView)
           settingsView.translatesAutoresizingMaskIntoConstraints = false
           settingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
           settingsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
           settingsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
           settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
       }
}
