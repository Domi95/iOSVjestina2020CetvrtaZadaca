//
//  FirstScreen.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 15/04/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import UIKit

class AboutQuizViewController: UIViewController {
    
    var quizService = QuizService()
    let questionController = QuestionController()
    let errorLabel = UILabel()
    let stackView = UIStackView()
    let aboutQuizView = AboutQuizView()

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        quizService.delegate = self
    }
    
    private func render(){
        setUpErrorLabel()
        configureStackView()
        aboutQuizView.dohvatiButton.addTarget(self, action: #selector(dohvatiPressed), for: .touchUpInside)
    }
    
    func configureStackView(){
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 100
        stackView.addArrangedSubview(self.aboutQuizView.stackView)
        stackView.addArrangedSubview(self.questionController.questionView.stackView)
        setStackViewConstraints()
       
    }
    
    func setStackViewConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setUpErrorLabel(){
        errorLabel.backgroundColor = .white
        errorLabel.text = "There was error linked to fetching data from web adress"
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.minimumScaleFactor = 0.5
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
    }
    
    @objc func dohvatiPressed(){
           //self.navigationController?.pushViewController(questionController, animated: true)
           quizService.fetchQuiz(with: "https://iosquiz.herokuapp.com/api/quizzes")
       }
    
    func findString(quizService: QuizService, quizModel: QuizModel) -> Int{
        return 2
    }
    
    func updateViewsElements(quizModel: QuizModel, numberOfQuestions: Int){
        
    }

}

extension AboutQuizViewController: QuizServiceDelegate {
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = false
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func didUpdateAboutQuizData(_ quizService: QuizService, quizModel: QuizModel) {
        DispatchQueue.main.async {
            var questionCounter = 0
            for i in 0...quizModel.question.count - 1{
                if quizModel.question[i].contains("NBA") {
                    questionCounter = questionCounter + 1
                }
            }
            self.aboutQuizView.funFactLabel.text = "Postoje \(questionCounter) pitanja koja u sebi sadrze rijec 'NBA'"
            self.aboutQuizView.quizTitleLabel.text = quizModel.title[0]
            
            switch quizModel.level[0] {
            case 1:
                self.aboutQuizView.quizTitleLabel.backgroundColor = .yellow
                self.aboutQuizView.quizImage.backgroundColor = .yellow
            case 2:
                self.aboutQuizView.quizTitleLabel.backgroundColor = .green
                self.aboutQuizView.quizImage.backgroundColor = .green
            default:
                print("Levels do not match")
            }
            self.updateQuizImage(imageString: quizModel.image)
            self.questionController.updateQuestionLabelAndButtonsTitle(quizModel:quizModel)
            self.configureStackView()
            //Show questionView stackView after succesfull load of data
            self.questionController.questionView.stackView.isHidden = false
           
        }
    }
    
    func updateQuizImage(imageString: [String]){
        if let url = URL(string: imageString[0]){
            
            do{
                let data = try Data(contentsOf: url)
                self.aboutQuizView.quizImage.image = UIImage(data: data)
            }catch let err{
                print("Error: \(err.localizedDescription)")
            }
        }
    }
}
