////
////  NetworkService.swift
////  WeatherApp
////
////  Created by Andrew Trach on 13.02.2022.
////
//
//import Foundation
//import Alamofire
//
//enum HTTPMethod: String {
//    case get = "GET"
//    case post = "POST"
//    case put = "PUT"
//    case delete = "DELETE"
//}
//enum Task {
//    case requestPlain
//    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
//}
//
////class NetworkService {
////
////    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding){
////         switch task {
////         case .requestPlain:
////             return ([:], URLEncoding.default)
////         case .requestParameters(parameters: let parameters, encoding: let encoding):
////             return (parameters, encoding)
////         }
////     }
////
//////    // 4
//////    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completionHandler:@escaping (Result<M, NSError>)-> Void) {
//////        // 5
//////        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
//////        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
//////        let parameters = buildParams(task: target.task)
//////
//////        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseJSON { (response) in
//////            // 6
//////            guard let statusCode = response.response?.statusCode else {
//////                print("StatusCode not found")
//////                completionHandler(.failure(NSError()))
//////                return
//////            }
//////
////            // 7
////            if statusCode == 200 {
////
////                // 8
////                guard let jsonResponse = try? response.result.get() else {
////                    print("jsonResponse error")
////                    completionHandler(.failure(NSError()))
////                    return
////                }
////                // 9
////                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
////                    print("theJSONData error")
////                    completionHandler(.failure(NSError()))
////                    return
////                }
////                // 10
////                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
////                    print("responseObj error")
////                    completionHandler(.failure(NSError()))
////                    return
////                }
////                completionHandler(.success(responseObj))
////
////            } else {
////                print("error statusCode is \(statusCode)")
////                completionHandler(.failure(NSError()))
////
////            }
////
////        }
////    }
////}
//
//protocol TargetType {
//    
//    var baseURL: String {get}
//    
//    var path: String {get}
//    
//    var method: HTTPMethod {get}
//    
//    var task: Task {get}
//    
//    var headers: [String: String]? {get}
//}
//
//enum RepositoriesNetworking {
//    case getRepos(username: String)
//}
//
//extension RepositoriesNetworking: TargetType {
//    var baseURL: String {
//        switch self {
//        default:
//            return  "https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=daily&appid=0fa1d0b79ddcafd56809796e37a2ff33"
//        }
//    }
//    
//    var path: String {
//        switch self {
//        case .getRepos(let username):
//            return "/users/\(username)/repos"
//        }
//    }
//    
//    var method: HTTPMethod {
//        switch self {
//        case .getRepos:
//            return .get
//        }
//    }
//    
//    var task: Task {
//        switch self {
//        case .getRepos:
//            return .requestPlain
//        }
//    }
//    
//    var headers: [String : String]? {
//        switch self {
//        default:
//            return [:]
//        }
//    }
//    
//}
//
//
//
//
//
//class NetworkManager {
//    
//    struct NewsError: Error {
//        var text: String
//    }
////
////    func getNews(lat: String, long: String, page: Int,
////                   success: @escaping ([Welcome]) -> Void,
////                   failure: @escaping (NewsError) -> () ) {
////
////        AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=daily&appid=0fa1d0b79ddcafd56809796e37a2ff33").responseJSON { response in
////                    if let error = self.observeError(with: response.value) {
////                        failure(error)
////                    } else if let jsonDict = response.result.value as? [String: Any] {
////            if let articlesDictArray = jsonDict["articles"] as? [[String: Any]] {
////                        var newsArray = [Welcome]()
////
////                        success(newsArray)
////                    } else {
////                        failure(NewsError.init(text: "Some error"))
////                    }
////                   }
////        }
////    }
//    
//    func observeError(with response: Any?) -> NewsError? {
//        if let dict = response as? [String: Any],
//           let error = dict["error"] as? String {
//            return NewsError(text: error)
//        }
//        return nil
//    }
//}
//
//
