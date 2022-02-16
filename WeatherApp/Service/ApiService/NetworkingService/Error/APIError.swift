//
//  ApiError.swift
//  NetworikngManager
//
//  Created by Andrew Trach on 12.02.2022.
//

import Foundation
import Alamofire

// MARK: - APIError

class APIError: Error {
    
    // MARK: - Constants
    
    struct DefaultMessage {
        static let parsingFaillure = "Parsing error"
    }
    
    // MARK: - Properties
    
    private(set) var message: String
    private(set) var statusCode: Int
    private(set) var localizedDescription: String = ""
    
    // MARK: - Initialization
    
    required init(message: String, statusCode: Int) {
        
        self.message = message
        self.statusCode = statusCode
    }
    
    convenience init(_ error: NSError) {
        self.init(message: error.localizedDescription, statusCode: error.code)
    }
    
    convenience init(_ error: Swift.Error) {
        
        let nsError = error as NSError
        self.init(message: nsError.localizedDescription, statusCode: nsError.code)
    }
    
    convenience init?(message: String?, statusCode: Int?) {
        
        guard
            let message = message,
            let statusCode = statusCode
        else {
            return nil
        }

        self.init(message: message, statusCode: statusCode)
    }
    
    init(statusCode: Int = -1, message: String = "No message") {
        
        self.statusCode = statusCode
        self.message = message
    }
    
    convenience init?(alamofireError: AFError) {
        self.init(message: alamofireError.errorDescription, statusCode: alamofireError.responseCode)
    }
    
    // MARK: - Static methods
    
    static func unknowError(message: String? = nil) -> APIError {
        .init(message: "Something wrong")
    }
}

