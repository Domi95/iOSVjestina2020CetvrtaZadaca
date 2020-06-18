//
//  DataPersistence.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 28/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import CoreData
import UIKit
import Foundation

class DataPersistence {
    var searchedQuizArrayNotParsed = [QuizCoreData]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var quizData: [Quiz] = []
    var searchedQuizData: [Quiz] = []
    var quizzesByCategory = [QuizzesByCategory]()
    
    var quizzesFromCoreDataNotParsed = [QuizCoreData]()
    var quizzesFromCoreDataParsed: [Quiz] = []
    var quizzesFromAPI: [Quiz] = []
    var newQuizzesFromAPI : [Quiz] = []
    
       func parseIntoCoreDataForm(quizData: [Quiz]){
            for quiz in quizData {
                let quizCoreData = QuizCoreData(context: self.context)
                quizCoreData.title = quiz.title
                quizCoreData.quizDescription = quiz.description
                quizCoreData.level = Int16(quiz.level)
                quizCoreData.image = quiz.image
                quizCoreData.id = Int16(quiz.id)
                quizCoreData.category = quiz.category.rawValue
                quizCoreData.questions = NSSet()
                for question in quiz.questions {
                    let questionCoreData = QuestionCoreData(context: self.context)
                    questionCoreData.question = question.question
                    questionCoreData.id = Int16(question.id)
                    questionCoreData.correct_answer = Int16(question.correctAnswer)
                    questionCoreData.answers = question.answers
                    quizCoreData.questions?.adding(questionCoreData)
                    questionCoreData.parentQuiz = quizCoreData
                }
                self.saveItems()
            }
        }
    
    func updateQuizzesFromCoreDataNotParsed(){
        parseIntoCoreDataForm(quizData: newQuizzesFromAPI)
    }
    
    func fillNewQuizzesFromAPI(){
        newQuizzesFromAPI = []
        for quizFromAPI in quizzesFromAPI {
            var quizExists = true
            for quizzFromCoreData in quizzesFromCoreDataParsed {
                if quizFromAPI.title == quizzFromCoreData.title {
                    quizExists = false
                }
            }
            if quizExists == true {
                newQuizzesFromAPI.append(quizFromAPI)
        }
    }
}
    
    func fillQuizzesFromAPI(quizzes: [Quiz]){
        quizzesFromAPI = []
        quizzesFromAPI = quizzes
    }
    
    func loadItemsFromCoreData(){
        let request: NSFetchRequest<QuizCoreData> = QuizCoreData.fetchRequest()
        do {
            quizzesFromCoreDataNotParsed = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func loadSearchedItemsFromCoreData(with request: NSFetchRequest<QuizCoreData>){
        do {
            searchedQuizArrayNotParsed = []
            searchedQuizArrayNotParsed = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func parseSearchedQuizArray() -> [Quiz]?{
        searchedQuizData = []
        for object in searchedQuizArrayNotParsed {
            var questionArray : [Question] = []
            for loopQuestion in object.questions?.allObjects as! [QuestionCoreData] {
                let question = Question(id: Int(loopQuestion.id), question: loopQuestion.question!, answers: loopQuestion.answers!, correctAnswer: Int(loopQuestion.correct_answer))
                questionArray.append(question)
            }
            let quiz = Quiz(category: Category(rawValue: object.category!) ?? Category.SPORTS, title: object.title!, image: object.image!, questions: questionArray, level: Int(object.level), description: object.quizDescription!, id: Int(object.id))
            searchedQuizData.append(quiz)
        }
        return searchedQuizData
    }
    
    func parseQuizesFromCoreData(completion: ([Quiz]) -> ()){
            quizzesFromCoreDataParsed = []
            for object in quizzesFromCoreDataNotParsed {
                var questionArray : [Question] = []
                for loopQuestion in object.questions?.allObjects as! [QuestionCoreData] {
                    let question = Question(id: Int(loopQuestion.id), question: loopQuestion.question!, answers: loopQuestion.answers!, correctAnswer: Int(loopQuestion.correct_answer))
                    questionArray.append(question)
                }
                let quiz = Quiz(category: Category(rawValue: object.category!) ?? Category.SPORTS, title: object.title!, image: object.image!, questions: questionArray, level: Int(object.level), description: object.quizDescription!, id: Int(object.id))
                quizzesFromCoreDataParsed.append(quiz)
            }
            completion(quizzesFromCoreDataParsed)
        }
    
    func saveItems(){
          do {
              try context.save()
          } catch {
              print("Error saving context \(error)")
          }
      }
}
