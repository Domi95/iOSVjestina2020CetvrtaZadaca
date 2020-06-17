//
//  CustomTabBarController.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 17/06/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import UIKit
import Foundation

class CustomTabBarController: UITabBarController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(win: UIWindow){
        super.init(nibName: nil, bundle: nil)
        window = win
        configureTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTabBar() {
        let quizzesMenuViewController = QuizzesMenuViewController()
        let quizItem = UITabBarItem()
        quizItem.title = "Quiz"
        quizItem.image = UIImage(named: "stopwatchPicture")
        let navigationController1 = UINavigationController(rootViewController: quizzesMenuViewController)
        navigationController1.tabBarItem = quizItem

        let searchViewController = SearchViewController()
        let searchItem = UITabBarItem()
        searchItem.title = "Search"
        searchItem.image = UIImage(named: "searchPicture")
        let navigationController2 = UINavigationController(rootViewController: searchViewController)
        navigationController2.tabBarItem = searchItem
        
        let settingsViewController = SettingsViewController(win: window!)
        let settingsItem = UITabBarItem()
        settingsItem.title = "Settings"
        settingsItem.image = UIImage(named: "settingsPicture")
        let navigationController3 = UINavigationController(rootViewController: settingsViewController)
        navigationController3.tabBarItem = settingsItem

        self.viewControllers = [navigationController1, navigationController2, navigationController3]
        self.selectedViewController = navigationController1
    }
}
