//
//  AboutQuizView.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 26/04/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class QuizzesMenuView: UIView {
    let tableView = UITableView()
    let quizImage = UIImageView()
    let getQuizButton = UIButton()
    let funFactLabel = UILabel()
    let funFactTitle = UILabel()
    let quizTitleLabel = UILabel()
    let errorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    private func render(){
        self.backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints  = false
        setUpQuizTitleLabel()
        setUpGetQuizButton()
        setUpFunFactTitle()
        setUpFunFactLabel()
        configureTableView()
        setUpErrorLabel()
        configureConstraints()
    }
    
    func configureConstraints(){
        quizTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        quizTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        quizTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        quizTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        quizTitleLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        getQuizButton.translatesAutoresizingMaskIntoConstraints = false
        getQuizButton.topAnchor.constraint(equalTo: quizTitleLabel.bottomAnchor, constant: 20).isActive = true
        getQuizButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        getQuizButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        getQuizButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        funFactTitle.translatesAutoresizingMaskIntoConstraints = false
        funFactTitle.topAnchor.constraint(equalTo: self.getQuizButton.bottomAnchor, constant: 10).isActive = true
        funFactTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        funFactTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        funFactTitle.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        funFactLabel.translatesAutoresizingMaskIntoConstraints = false
        funFactLabel.topAnchor.constraint(equalTo: self.funFactTitle.bottomAnchor, constant: 0).isActive = true
        funFactLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        funFactLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        funFactLabel.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
    }
    
    func configureTableView(){
        self.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 143
        tableView.topAnchor.constraint(equalTo: self.funFactLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.isHidden = true
    }
    
    func setUpErrorLabel(){
        self.addSubview(errorLabel)
        errorLabel.backgroundColor = .black
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.minimumScaleFactor = 0.5
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        errorLabel.textColor = UIColor.white
        errorLabel.text = "ERROR! Fetching data was unsuccessful"
        errorLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
    }
    
    private func setUpFunFactLabel(){
        self.addSubview(funFactLabel)
        funFactLabel.backgroundColor = .black
        funFactLabel.adjustsFontSizeToFitWidth = true
        funFactLabel.minimumScaleFactor = 0.5
        funFactLabel.textAlignment = .center
        funFactLabel.isHidden = true
        funFactLabel.textColor = UIColor.white
        funFactLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
    }
    
    private func setUpQuizTitleLabel() {
        self.addSubview(quizTitleLabel)
        quizTitleLabel.backgroundColor = .black
        quizTitleLabel.adjustsFontSizeToFitWidth = true
        quizTitleLabel.minimumScaleFactor = 0.5
        quizTitleLabel.textAlignment = .center
        quizTitleLabel.text = "Pop Quiz"
        quizTitleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 24.0)
        quizTitleLabel.textColor = UIColor.white
    }
    
    private func setUpGetQuizButton() {
        self.addSubview(getQuizButton)
        getQuizButton.backgroundColor = .white
        getQuizButton.setTitleColor(.black, for: .normal)
        getQuizButton.setTitle("Get Quiz", for: .normal)
        getQuizButton.backgroundColor = .gray
        getQuizButton.layer.cornerRadius = 20
        getQuizButton.layer.borderWidth = 1
    }
    
    private func setUpFunFactTitle() {
        self.addSubview(funFactTitle)
        funFactTitle.backgroundColor = .black
        funFactTitle.adjustsFontSizeToFitWidth = true
        funFactTitle.minimumScaleFactor = 0.5
        funFactTitle.textAlignment = .center
        funFactTitle.text = "💡 Fun Fact"
        funFactTitle.isHidden = true
        funFactTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 24.0)
        funFactTitle.textColor = UIColor.white
    }
    
    func hideElementsBecauseOfFetchingError(){
        quizTitleLabel.isHidden = true
        funFactLabel.isHidden = true
        funFactTitle.isHidden = true
        errorLabel.isHidden = false
    }
    
    func unhideElements(){
        quizTitleLabel.isHidden = false
        funFactLabel.isHidden = false
        funFactTitle.isHidden = false
        errorLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
