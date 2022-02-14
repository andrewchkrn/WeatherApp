//
//  Task.swift
//  NetworikngManager
//
//  Created by Andrew Trach on 12.02.2022.
//

import Foundation
import Alamofire

// MARK: - Task
enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}
