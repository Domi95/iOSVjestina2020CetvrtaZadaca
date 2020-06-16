//
//  LoggingService.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 11/06/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

class LoggingService {
    
    func saveDataToUserDefaults(data: ServerResponseData){
        let defaults = UserDefaults.standard
        defaults.set(data.token, forKey: "Token")
        defaults.set(data.user_id, forKey: "Id")
    }
    
    func logOutUser(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "Id")
        defaults.removeObject(forKey: "Token")
    }
    
    func returnLogedInUsername() -> String? {
        let defaults = UserDefaults.standard
        guard let username = defaults.string(forKey: "Id") else {
            return "Username"
        }
        return username
    }
    
    func makeURLRequest(username: String, password: String, completion: @escaping(Bool) -> ()){
           let url = URL(string: "https://iosquiz.herokuapp.com/api/session")!
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           
           let parameters = "username=\(username)&password=\(password)"
           request.httpBody = parameters.data(using: String.Encoding.utf8);
           
           let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               if let error = error {
                   completion(false)
                   print("Error took place \(error)")
                   return
               }
               if let data = data {
                   let decodedData = self.parseJSONurlServerResponse(data)
                   if decodedData?.errorMessege != "" {
                       completion(false)
                   } else {
                       self.saveDataToUserDefaults(data: decodedData!)
                       completion(true)
                   }
               }
           }
           task.resume()
       }
    
    func parseJSONurlServerResponse(_ serverResponse: Data) -> ServerResponseData? {
         let decoder = JSONDecoder()
         do {
             let decodedData = try decoder.decode(ServerResponseData.self, from: serverResponse)
             return decodedData
         } catch {
             return nil
         }
     }
}
