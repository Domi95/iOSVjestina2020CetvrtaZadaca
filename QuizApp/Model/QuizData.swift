import Foundation
import UIKit

struct QuizData: Decodable {
    var quizzes: [Quiz]
}

struct Quiz: Decodable {
   var category: Category
   var title: String?
   var image: String
   var questions: [Question]
   var level: Int
   var description: String
   var id: Int
}

struct Question: Decodable {
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case question = "question"
        case answers = "answers"
        case correctAnswer = "correct_answer"
    }
   var id: Int
   var question: String
   var answers: [String]
   var correctAnswer: Int
}

struct QuizzesByCategory {
    var category: Category
    var quizzes : [Quiz]
}

enum Category: String, Decodable, CaseIterable {
    case SPORTS, SCIENCE
}

struct AnswerInformation {
    var color: UIColor
    var buttonId: Int
}



