//
//  File.swift
//  QuizApp
//
//  Created by Domagoj Beronic on 05/05/2020.
//  Copyright © 2020 Domagoj Beronic. All rights reserved.
//

import Foundation
import UIKit

struct ServerResponseData: Decodable {
    let token: String
    let user_id: Int
    let errorMessege = ""
}
