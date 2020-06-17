//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 17/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardViewController: UIViewController {
    var leaderboardView = LeaderboardView()
    let quizService = QuizService()
    var top20Players: [QuizBestPlayerData] = []
    var quizzId: Quiz!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardView.tableView.dataSource = self
        render()
    }
    
    func render(){
        setUpLeaderboardView()
        leaderboardView.tableView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellReuseIdentifier: "PlayerReusableCell")
        setUpButtonsActions()
    }
    func showLeaderboardData(quizzId: Int) {
            quizService.getQuizLeaderboard(quizzId: quizzId, completion: { (quizData) in
                self.removePeopleWhoAreNotInTop20(quizPlayers: quizData)
                DispatchQueue.main.async{
                 self.leaderboardView.tableView.reloadData()
                }
        })
    }
    
    func showPopMessage(){
        leaderboardView.popMessage.isHidden = false
        leaderboardView.tableView.isHidden = true
        leaderboardView.playerLabel.isHidden = true
        leaderboardView.pointsLabel.isHidden = true
    }
    
     func removePeopleWhoAreNotInTop20(quizPlayers: [QuizBestPlayerData]){
        var counter = 0
        for player in quizPlayers{
            if (player.score != nil && player.username != nil){
            self.top20Players.append(player)
            counter = counter + 1
            }
            if counter == 20 {
                break
            }
        }
    }
    
    @objc func xButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpButtonsActions(){
        leaderboardView.xButton.addTarget(self, action: #selector(xButtonPressed), for: .touchUpInside)
    }
    
    func setUpLeaderboardView(){
        view.addSubview(leaderboardView)
        leaderboardView.translatesAutoresizingMaskIntoConstraints = false
        leaderboardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        leaderboardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        leaderboardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        leaderboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return top20Players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.leaderboardView.tableView.dequeueReusableCell(withIdentifier: "PlayerReusableCell", for: indexPath) as! PlayerCell
        cell.placeNumber.text = String("\(indexPath.row + 1).")
        cell.usernameLabel.text = self.top20Players[indexPath.row].username
        cell.backgroundColor = .black
        let doubleValue = Double(top20Players[indexPath.row].score!) 
        cell.pointsLabel.text = String(format: "%.0f", doubleValue!)
        return cell
    }
}
