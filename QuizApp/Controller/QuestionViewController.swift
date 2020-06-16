//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 08/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    let quizService = QuizService()
    var startQuizView = StartQuizView()
    let leaderboardButton = UIButton()
    var quizz: Quiz!
    var currentQuestion = 0
    var timer = Timer()
    var correctAnswersCounter = 0
    var startTime = NSDate()
    var leaderboardViewController = LeaderboardViewController()
    var progressLabels = [UILabel]()
    let currentQuestionLabel = UILabel()
    
    private var scrollView = UIScrollView(frame: .zero)
    private var stackView = UIStackView(frame: .zero)
    var questionViews = [QuestionView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        render()
    }
    
    func render(){
        setUpStartQuizView()
        setUpButtonsActions()
        setUpLeaderboardButton()
        setNavigationBar()
        setUpProgressLabels()
    }
    
    func quizEnded(){
        quizService.sendQuizzesResult(startTime: startTime, quizzId: quizz.id, correctAnswersCounter: correctAnswersCounter)
        self.navigationController?.popViewController(animated: true)
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
    @objc func buttonsWithAnswersPressed(_ sender: UIButton){
        currentQuestion += 1
        currentQuestionLabel.text = "\(currentQuestion+1)/\(quizz.questions.count)"
        if currentQuestion == 10 {
            print("current question == 10")
            quizEnded()
            return
        }
        if sender.tag == quizz.questions[currentQuestion].correct_answer {
            correctAnswerPressed(buttonsId: sender.tag)
        }
        else {
            incorrectAnswerPressed(buttonsId: sender.tag)
        }
    }
    
    func correctAnswerPressed(buttonsId: Int){
        progressLabels[currentQuestion-1].backgroundColor = .green
        timer.invalidate()
        correctAnswersCounter += 1
        switch buttonsId {
        case 0:
            questionViews[currentQuestion-1].buttonA.backgroundColor = .green
        case 1:
            questionViews[currentQuestion-1].buttonB.backgroundColor = .green
        case 2:
            questionViews[currentQuestion-1].buttonC.backgroundColor = .green
        case 3:
            questionViews[currentQuestion-1].buttonD.backgroundColor = .green
        default:
            print("Error after buttons backgroundcolor change")
        }
        self.scrollToPage(page: currentQuestion, animated: true)
        if (currentQuestion == 10)
        {
            quizEnded()
            return
        }
    }
    
    func incorrectAnswerPressed(buttonsId: Int){
        progressLabels[currentQuestion-1].backgroundColor = .red
        switch buttonsId {
        case 0:
            questionViews[currentQuestion-1].buttonA.backgroundColor = .red
        case 1:
            questionViews[currentQuestion-1].buttonB.backgroundColor = .red
        case 2:
            questionViews[currentQuestion-1].buttonC.backgroundColor = .red
        case 3:
            questionViews[currentQuestion-1].buttonD.backgroundColor = .red
        default:
            print("Error after buttons backgroundcolor change")
        }
        self.scrollToPage(page: currentQuestion, animated: true)
        if (currentQuestion == 10)
        {
            quizEnded()
            return
        }
    }
    
    @objc func startButtonPressed(){
        self.navigationController?.isNavigationBarHidden = true
        startQuizView.isHidden = true
        startTime = NSDate()
        setUpQuestionViewsData()
        setUpQuestionView()
        setUpQuestionViewsButtonsAction()
        leaderboardButton.isHidden = true
        unhideProgressLabels()
    }
    
    @objc func leaderboardPressed() {
        leaderboardViewController.showLeaderboardData(quizzId: quizz.id)
        self.navigationController?.pushViewController(leaderboardViewController, animated: true)
    }
    
    
    func setUpButtonsActions(){
        startQuizView.startQuizButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        leaderboardButton.addTarget(self, action: #selector(leaderboardPressed), for: .touchUpInside)
    }
    
    func setUpQuestionViewsButtonsAction(){
        for questionView in questionViews {
            questionView.buttonA.addTarget(self,action: #selector(buttonsWithAnswersPressed), for: .touchUpInside)
            questionView.buttonB.addTarget(self,action: #selector(buttonsWithAnswersPressed), for: .touchUpInside)
            questionView.buttonC.addTarget(self,action: #selector(buttonsWithAnswersPressed), for: .touchUpInside)
            questionView.buttonD.addTarget(self,action: #selector(buttonsWithAnswersPressed), for: .touchUpInside)
        }
    }
    
    func setUpStartQuizView(){
        view.addSubview(startQuizView)
        startQuizView.translatesAutoresizingMaskIntoConstraints = false
        startQuizView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        startQuizView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        startQuizView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        startQuizView.heightAnchor.constraint(equalToConstant: 414).isActive = true
    }
    
    func setUpLeaderboardButton(){
        view.addSubview(leaderboardButton)
        leaderboardButton.setTitle("Leaderboard", for: .normal)
        leaderboardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        leaderboardButton.translatesAutoresizingMaskIntoConstraints = false
        leaderboardButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        leaderboardButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        leaderboardButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
        leaderboardButton.widthAnchor.constraint(equalToConstant: 102).isActive = true
    }
    
    func setNavigationBar(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.title = "PopQuiz"
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    private func setUpQuestionViewsData(){
        
        for question in quizz.questions {
            let questionView = QuestionView()
            questionView.questionLabel.text = question.question
            questionView.buttonA.setTitle(question.answers[0], for: .normal)
            questionView.buttonB.setTitle(question.answers[1], for: .normal)
            questionView.buttonC.setTitle(question.answers[2], for: .normal)
            questionView.buttonD.setTitle(question.answers[3], for: .normal)
            questionViews.append(questionView)
        }
    }
    
    private func setUpQuestionView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -10),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10)
        ])
        
        questionViews.forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(view)
            view.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        }
    }
    private func setUpProgressLabels(){
        let viewWidth = Int(view.bounds.width)
        let progressLabelWidth = (viewWidth - 40 - (quizz.questions.count - 2) * 7) / quizz.questions.count
        //40 is sum of spacing of left and right side progressLabel and view
        //quizz.questions.count * 7 is reserved for sum of spacing between progress labels
        
        for i in 0...quizz.questions.count - 1 {
            let progressLabel = UILabel()
            progressLabel.isHidden = true
            progressLabel.backgroundColor = .gray
            progressLabel.translatesAutoresizingMaskIntoConstraints = false
            progressLabel.layer.cornerRadius = 5
            self.view.addSubview(progressLabel)
            progressLabels.append(progressLabel)
            progressLabels[i].topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
            if i == 0 {
                progressLabels[i].leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
            } else {
                progressLabels[i].leftAnchor.constraint(equalTo: progressLabels[i-1].rightAnchor, constant: 7).isActive = true
            }
            progressLabels[i].heightAnchor.constraint(equalToConstant: 5).isActive = true
            progressLabels[i].widthAnchor.constraint(equalToConstant: CGFloat(progressLabelWidth)).isActive = true
        }
        
        currentQuestionLabel.text = "1/\(quizz.questions.count)"
        currentQuestionLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        currentQuestionLabel.textColor = UIColor.white
        currentQuestionLabel.isHidden = true
        currentQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(currentQuestionLabel)
        currentQuestionLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        currentQuestionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        currentQuestionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        currentQuestionLabel.widthAnchor.constraint(equalToConstant: 63).isActive = true
    }
    
    func unhideProgressLabels(){
        for progressLabel in progressLabels {
            progressLabel.isHidden = false
        }
        currentQuestionLabel.isHidden = false
    }
}

