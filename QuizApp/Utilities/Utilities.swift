//
//  Utilities.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 09/06/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    func fillQuizzesByCategory(quizzes: [Quiz]) -> [QuizzesByCategory]{
        
        var quizzesByCategory = [QuizzesByCategory]()
        
        for category in Category.allCases {
            
            let sortedQuizzes = quizzes.filter( { (quiz) in
                return quiz.category == category
            })
            if sortedQuizzes.count > 0 {
                let quizzesInOneCategory = QuizzesByCategory(category: category, quizzes: sortedQuizzes)

                quizzesByCategory.append(quizzesInOneCategory)
            }
            
        }
        return quizzesByCategory
    }
}
