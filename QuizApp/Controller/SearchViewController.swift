//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 16/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SearchViewController: UIViewController {
    let searchView = SearchView()
    let utilities = Utilities()
    let dataPersistence = DataPersistence()
    var quizzesByCategory: [QuizzesByCategory] = []
    var searchedWord = "safasmifgnodg"
    var quizzesMenuViewController = QuizzesMenuViewController()
    let quizService = QuizService()
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
        render()
    }
    
    func render(){
        self.navigationController?.isNavigationBarHidden = true
        setUplogInView()
        setUpButtonsActions()
        searchView.tableView.register(UINib(nibName: "QuizCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    @objc func searchButtonPressed(){
        let word = searchView.searchTextField.text ?? ""
        if word != "" {
            searchedWord = word
        }
        updateQuizzesWithResultsOfSearchedWord(with: word)
    }
    
    func updateQuizzesWithResultsOfSearchedWord(with word: String){
        let request : NSFetchRequest<QuizCoreData> = QuizCoreData.fetchRequest()
        let predicate1 = NSPredicate(format: "title CONTAINS[cd] %@", word)
        let predicate2 = NSPredicate(format: "quizDescription CONTAINS[cd] %@", word)
        let compound = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1, predicate2])
        request.predicate = compound
        dataPersistence.loadSearchedItemsFromCoreData(with: request)
        if let quizzesWithSearchedWord = dataPersistence.parseSearchedQuizArray()
        {
            quizzesByCategory = utilities.fillQuizzesByCategory(quizzes: quizzesWithSearchedWord)
        }
        searchView.tableView.isHidden = false
        DispatchQueue.main.async {
            self.searchView.tableView.reloadData()
        }
    }
    
    func setUpButtonsActions(){
        searchView.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
    }
    
    func setUplogInView(){
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        searchView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        searchView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

// MARK:- TableView methods

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        searchView.tableView.isHidden = false
        let cell = self.searchView.tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! QuizCell
        cell.quizTitle.text = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row].title
        cell.cellQuizDescription.text = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row].description
        cell.cellImage.image = quizService.updateQuizImage(imageString: quizzesByCategory[indexPath.section].quizzes[indexPath.row].image)
        cell.cellImage?.contentMode = .scaleToFill
        cell.selectionStyle = .none
        var color: UIColor
        
        if indexPath.section == 0 {
            color = myColor.tableViewLevelAndSectionTitleColor1
        } else {
            color = myColor.tableViewLevelAndSectionTitleColor2
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizzesByCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzesByCategory[section].quizzes.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel()
        if quizzesByCategory[section].category.rawValue == "SPORTS" {
            sectionLabel.textColor = myColor.tableViewLevelAndSectionTitleColor1
        } else {
            sectionLabel.textColor = myColor.tableViewLevelAndSectionTitleColor2
        }
        sectionLabel.text = quizzesByCategory[section].category.rawValue
        sectionLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        return sectionLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let questionViewController = QuestionViewController()
        questionViewController.startQuizView.quizTitle.text = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row].title
        questionViewController.startQuizView.quizDescription.text = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row].description
        questionViewController.startQuizView.quizImage.image = quizService.updateQuizImage(imageString: quizzesByCategory[indexPath.section].quizzes[indexPath.row].image)
        self.navigationController?.pushViewController(questionViewController, animated: true)
        questionViewController.quizz = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row]
    }
}
