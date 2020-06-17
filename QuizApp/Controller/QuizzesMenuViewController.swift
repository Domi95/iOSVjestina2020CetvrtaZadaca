//
//  ListOfQuizzesViewController.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 06/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Reachability

class QuizzesMenuViewController: UIViewController {
    var quizService = QuizService()
    var dataPersistence = DataPersistence()
    let quizzesMenuView = QuizzesMenuView()
    var quizzesByCategory: [QuizzesByCategory] = []
    let utilities = Utilities()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        self.navigationController?.isNavigationBarHidden = true
        quizzesMenuView.tableView.dataSource = self
        quizzesMenuView.tableView.delegate = self
        view.backgroundColor = .black
        render()
    }
    
    func render(){
        setUpQuizInformationView()
        setUpButtonsActions()
        quizzesMenuView.tableView.register(UINib(nibName: "QuizCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    func updateCoreDataQuizzes(){
        quizService.fetchQuiz(with: "https://iosquiz.herokuapp.com/api/quizzes", completion: { (quizData) in
            self.dataPersistence.fillQuizzesFromAPI(quizzes: quizData)
            self.dataPersistence.fillNewQuizzesFromAPI()
            self.dataPersistence.updateQuizzesFromCoreDataNotParsed()
            self.getQuizzesWithCoreData()
        })
    }
    
    func getQuizzesWithCoreData(){
        dataPersistence.loadItemsFromCoreData()
        dataPersistence.parseQuizesFromCoreData(completion: { (quizzes) in
            updateQuizData(quizzes: quizzes)
        })
    }
    
    func updateQuizData(quizzes: [Quiz]){
        DispatchQueue.main.async {
            self.quizzesByCategory = self.utilities.fillQuizzesByCategory(quizzes: quizzes)
            if self.quizzesByCategory.isEmpty {
                self.quizzesMenuView.hideElementsBecauseOfFetchingError()
            } else {
                self.findStringNBA(quizzesByCategory: self.quizzesByCategory)
                self.quizzesMenuView.tableView.reloadData()
                self.quizzesMenuView.unhideElements()
            }
        }
    }
    
    func findStringNBA(quizzesByCategory: [QuizzesByCategory]){
        var questionArray: [String] = []
        if quizzesByCategory.count == 0  {
            return
        }
        for quizByCategory in quizzesByCategory {
            for quiz in quizByCategory.quizzes {
                for question in quiz.questions {
                    questionArray.append(question.question)
                }
            }
        }
        let containsNbaString = questionArray.filter({$0.contains("NBA")})
        quizzesMenuView.funFactLabel.text = "Postoje \(containsNbaString.count) pitanja koja u sebi sadrze rijec 'NBA'"
    }
    
    @objc func getQuizPressed(){
        checkConnection()
        getQuizzesWithCoreData()
        updateCoreDataQuizzes()
    }
    
    func checkConnection(){
        let reachability = try! Reachability()
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        switch (reachability.connection) {
        case .unavailable: getQuizzesWithCoreData()
        default: updateCoreDataQuizzes()
        }
    }
    
    func setUpButtonsActions(){
        quizzesMenuView.getQuizButton.addTarget(self, action: #selector(getQuizPressed), for: .touchUpInside)
    }
    
    func updateQuizImage(imageString: String) -> UIImage{
        if let url = URL(string: imageString){
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)!
            } catch let err{
                print("Error: \(err.localizedDescription)")
            }
        }
        return UIImage()
    }
    
    func setUpQuizInformationView(){
        view.addSubview(quizzesMenuView)
        quizzesMenuView.translatesAutoresizingMaskIntoConstraints = false
        quizzesMenuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        quizzesMenuView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        quizzesMenuView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        quizzesMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
}
// MARK:- TableView methods
extension QuizzesMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return quizzesByCategory[0].quizzes.count
        }
        else {
            return quizzesByCategory[1].quizzes.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizzesByCategory.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel()
        switch section {
        case 0:
            sectionLabel.text = "Sports"
            sectionLabel.textColor = .systemBlue
        case 1:
            sectionLabel.text = "Science"
            sectionLabel.textColor = .brown
        default:
            sectionLabel.text = "WorldKnowledge"
        }
        
        sectionLabel.backgroundColor = .black
        sectionLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        return sectionLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        quizzesMenuView.tableView.isHidden = false
        let cell = self.quizzesMenuView.tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! QuizCell
        cell.quizTitle.text = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row].title
        cell.cellQuizDescription.text = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row].description
        cell.cellImage?.contentMode = .scaleToFill
        cell.cellImage.image = self.updateQuizImage(imageString: quizzesByCategory[indexPath.section].quizzes[indexPath.row].image)
        cell.selectionStyle = .none
        
        var color: UIColor
        if indexPath.section == 0 {
            color = .systemBlue
        } else {
            color = .brown
        }
        switch quizzesByCategory[indexPath.section].quizzes[indexPath.row].level {
        case 1 :
            cell.imageLevel1.tintColor = color
        case 2:
            cell.imageLevel1.tintColor = color
            cell.imageLevel2.tintColor = color
        case 3:
            cell.imageLevel1.tintColor = color
            cell.imageLevel2.tintColor = color
            cell.imageLevel3.tintColor = color
        default: cell.imageLevel1.tintColor = .lightGray
        cell.imageLevel2.tintColor = .lightGray
        cell.imageLevel3.tintColor = .lightGray
        }
        return cell
    }
}

extension QuizzesMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let questionViewController = QuestionViewController()
        questionViewController.startQuizView.quizTitle.text = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row].title
        questionViewController.startQuizView.quizDescription.text = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row].description
        questionViewController.startQuizView.quizImage.image = self.updateQuizImage(imageString: quizzesByCategory[indexPath.section].quizzes[indexPath.row].image)
        self.navigationController?.pushViewController(questionViewController, animated: true)
        questionViewController.quizz = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row]
    }
}
