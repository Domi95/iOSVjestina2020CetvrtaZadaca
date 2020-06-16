//
//  RootViewController.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 16/06/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
           super.viewDidLoad()
           self.view.backgroundColor = .black
           setUpNavigationControllers()
       }
    
    func setUpNavigationControllers(){
        let tabBarController1 = UITabBarController()
        var navigationController1 = UINavigationController()
        var navigationController2 = UINavigationController()
        let logInViewController = LoginViewController()
        let quizItem = UITabBarItem()
        quizItem.title = "Quiz"
        quizItem.image = UIImage(named: "stopwatchPicture")
        logInViewController.tabBarItem = quizItem
        
        navigationController1 = UINavigationController(rootViewController: logInViewController)

        let searchViewController = SearchViewController()
        let searchItem = UITabBarItem()
        searchItem.title = "Search"
        searchItem.image = UIImage(named: "searchPicture")
        searchViewController.tabBarItem = searchItem
        navigationController2 = UINavigationController(rootViewController: searchViewController)
        
        let settingsViewController = SettingsViewController()
        let settingsItem = UITabBarItem()
        settingsItem.title = "Settings"
        settingsItem.image = UIImage(named: "settingsPicture")
        settingsViewController.tabBarItem = settingsItem

        tabBarController1.viewControllers = [navigationController1, navigationController2, settingsViewController]
        tabBarController1.selectedViewController = navigationController1
        
        self.navigationController?.pushViewController(tabBarController1, animated: true)
    }
    
}
