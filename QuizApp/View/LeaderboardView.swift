//
//  LeaderboardView.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 17/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardView: UIView {
    let tableView = UITableView()
    let playerLabel = UILabel()
    let pointsLabel = UILabel()
    let leaderboardLabel = UILabel()
    let xButton = UIButton()
    let popMessage = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    private func render() {
        self.backgroundColor = .black
        configureTableView()
        setUpElements()
        configureConstraints()
    }
    
    func configureTableView(){
        self.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 60
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
    }
    
    func setUpElements(){
        self.addSubview(playerLabel)
        playerLabel.text = "Player"
        playerLabel.textColor = UIColor.white
        
        self.addSubview(pointsLabel)
        pointsLabel.text = "Points"
        pointsLabel.textColor = UIColor.white
        
        self.addSubview(leaderboardLabel)
        leaderboardLabel.text = "Leaderboard"
        leaderboardLabel.textColor = UIColor.white
        leaderboardLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 24.0)
        leaderboardLabel.adjustsFontSizeToFitWidth = true
        
        self.addSubview(xButton)
        xButton.setTitle("✕", for: .normal)
        xButton.setTitleColor(.white, for: .normal)
        xButton.titleLabel?.font =  UIFont(name: "HelveticNeue-Bold", size: 50)
        
        self.addSubview(popMessage)
        popMessage.text = "Quiz results are not available at the moment. We are sorry!"
        popMessage.textColor = UIColor.white
        popMessage.font = UIFont(name:"HelveticaNeue-Bold", size: 24.0)
        popMessage.adjustsFontSizeToFitWidth = true
        popMessage.isHidden = true
    }
    
    private func configureConstraints(){
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 174).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        playerLabel.translatesAutoresizingMaskIntoConstraints = false
        playerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 140).isActive = true
        playerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        playerLabel.widthAnchor.constraint(equalToConstant: 102).isActive = true
        playerLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 140).isActive = true
        pointsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        pointsLabel.widthAnchor.constraint(equalToConstant: 57).isActive = true
        pointsLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        leaderboardLabel.translatesAutoresizingMaskIntoConstraints = false
        leaderboardLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 61).isActive = true
        leaderboardLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        leaderboardLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        leaderboardLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 61).isActive = true
        xButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 150).isActive = true
        xButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        xButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        popMessage.translatesAutoresizingMaskIntoConstraints = false
        popMessage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        popMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        popMessage.widthAnchor.constraint(equalToConstant: 350).isActive = true
        popMessage.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
