import Foundation
import UIKit

protocol QuizServiceDelegate {
    func didFailWithError(error: Error)
    func didUpdateAboutQuizData(_ quizService: QuizService, quizData: QuizData)
}

struct QuizService {
    var delegate: QuizServiceDelegate?
    
    func parseQuizPlayersResults(_ serverResponse: Data) -> [QuizBestPlayerData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([QuizBestPlayerData].self, from: serverResponse)
            return decodedData
        } catch {
            print("dogodio se error u parseQuizPlayersResults metodi")
            return nil
        }
    }
    func sendQuizzesResult(startTime: NSDate, quizzId: Int, correctAnswersCounter: Int){
        let defaults = UserDefaults.standard
        let end = NSDate()
        let timeInterval: Double = end.timeIntervalSince(startTime as Date)
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/result") else {
            return
        }
        guard let token = defaults.object(forKey: "Token") else {
            return
        }
        guard let userId = defaults.object(forKey: "id") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        let json = [
            "quiz_id": quizzId,
            "user_id": userId,
            "time": timeInterval,
            "no_of_correct": correctAnswersCounter
        ]
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        request.httpBody = data
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
        }
        task.resume()
    }
    
    func getQuizLeaderboard(quizzId: Int, completion: @escaping([QuizBestPlayerData]) -> ()){
        let defaults = UserDefaults.standard
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/score?quiz_id=\(quizzId)")
            else {
                print("error in getquizLeaderboard")
                return
        }
        
        var request = URLRequest(url: url)
        guard let token = defaults.object(forKey: "Token") else {
            print("Token not found")
            return
        }
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let safeData = data {
                if let quizPlayers = self.parseQuizPlayersResults(safeData) {
                    completion(quizPlayers)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ quizData: Data) -> QuizData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(QuizData.self, from: quizData)
            return decodedData
        } catch {
            print("error while parsing")
            return nil
        }
    }
    
    func fetchQuiz(with quizUrlString: String, completion: @escaping([Quiz]) -> ()){
        if let url = URL(string: quizUrlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("error while fetching data")
                    return
                }
                if let safeData = data {
                    if let quizData = self.parseJSON(safeData)  {
                        completion(quizData.quizzes)
                    }
                }
            }
            task.resume()
        }
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
}
