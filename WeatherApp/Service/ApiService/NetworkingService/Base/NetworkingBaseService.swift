//
//  NetworkingService.swift
//  NetworikngManager
//
//  Created by Andrew Trach on 12.02.2022.
//

import Foundation
import Alamofire

// MARK: - NetworkingBaseService
 class NetworkingBaseService<T:TargetType> {

    // MARK: - Private methods

    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {

        switch task {

            case .requestPlain:
                return ([:], URLEncoding.default)

            case .requestParameters(parameters: let parameters, encoding: let encoding):
                return (parameters, encoding)
        }
    }

    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completionHandler:@escaping (Result<M, NSError>)-> Void) {

        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)


        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseData { response in
            
            guard let statusCode = response.response?.statusCode else {

                let statusCodeNotFound = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "StatusCode not found"])
                completionHandler(.failure(statusCodeNotFound))
                return
            }

            if (200...299).contains(statusCode) {

                guard let data = response.data,
                    let responseObj = try? JSONDecoder().decode(M.self, from: data) else {
                    let parsingError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Parsing error"])

                    completionHandler(.failure(parsingError))
                    return
                }
                
                completionHandler(.success(responseObj))

            } else {
                let statusCodeError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error statusCode + \(statusCode)"])
                
                completionHandler(.failure(statusCodeError))

            }
        }
    }
}
