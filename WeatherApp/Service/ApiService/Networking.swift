//
//  ApiServise.swift
//  NetworikngManager
//
//  Created by Andrew Trach on 12.02.2022.
//

import Foundation
import Alamofire

// MARK: - ApiServise

enum Networking {
    case getWeather(form: OpenWeatherForm)
}

// MARK: - ApiServise

extension Networking: TargetType {

    // MARK: - Static properties

    var appid: String  {
        return "0fa1d0b79ddcafd56809796e37a2ff33"
    }
    
    var baseURL: String {
        
        switch self {
            default:
                return "https://api.openweathermap.org"
        }
    }
    
    var path: String {

        switch self {
        case .getWeather:
            break
        }
        return "/data/2.5/onecall"
    }

    var method: HTTPMethod {
        switch self {
            case .getWeather:
                return .get
        }
    }

    var task: Task {
        
        switch self {
            case .getWeather(let parameters):
            return .requestParameters(parameters: parameters.asDictionary, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {

        switch self {
            default:
                return [:]
        }
    }

}
