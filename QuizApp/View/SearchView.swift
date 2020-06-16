//
//  SearchView.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 06/06/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class SearchView: UIView {
    let searchTextField = UITextField()
    let searchButton = UIButton()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    func render(){
        self.backgroundColor = .black
        setUpElements()
        setUpConstraints()
    }
    
    func setUpElements(){
        self.addSubview(searchButton)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Bold", size: 16)
        
        self.addSubview(searchTextField)
        searchTextField.layer.cornerRadius = 20
        searchTextField.clipsToBounds = true
        searchTextField.placeholder = "Type here"
        searchTextField.backgroundColor = .darkGray
        
        self.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.rowHeight = 143
        tableView.isHidden = true
    }
    
    func setUpConstraints(){
       searchTextField.translatesAutoresizingMaskIntoConstraints = false
       searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 68).isActive = true
       searchTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 21).isActive = true
       searchTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
       searchTextField.widthAnchor.constraint(equalToConstant: 265).isActive = true
        
       searchButton.translatesAutoresizingMaskIntoConstraints = false
       searchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 79).isActive = true
       searchButton.leftAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: 20).isActive = true
       searchButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
       searchButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
      
       tableView.translatesAutoresizingMaskIntoConstraints = false
       tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 81).isActive = true
       tableView.leftAnchor.constraint(equalTo: searchTextField.leftAnchor).isActive = true
       tableView.rightAnchor.constraint(equalTo: searchButton.rightAnchor).isActive = true
       tableView.heightAnchor.constraint(equalToConstant: 370).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}

