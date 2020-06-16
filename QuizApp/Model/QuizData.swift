import Foundation

struct QuizData: Decodable {
    var quizzes : [Quiz]
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
   var id: Int
   var question: String
   var answers: [String]
   var correct_answer: Int
}

struct QuizzesByCategory {
    var category: Category
    var quizzes : [Quiz]
}

enum Category: String, Decodable, CaseIterable {
    case SPORTS, SCIENCE
}

