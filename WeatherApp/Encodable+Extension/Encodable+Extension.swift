//
//  Encodable+Extension.swift
//  NetworikngManager
//
//  Created by Andrew Trach on 12.02.2022.
//

import Foundation

//MARK: - Encodable
extension Encodable {
    
    // MARK: - Properties
    
    var asDictionary: [String: Any] {
        
        do {
            
            let data = try JSONEncoder().encode(self)
            
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                
                print("DS EncodableExtension | Error during encoding | \(self)")
                return [:]
            }
            
            return dictionary
        } catch let error {
            
            print("DS EncodableExtension | Error during encoding | \(error)")
            return [:]
        }
    }
    
    func asJSON() -> String? {
     
        let dictionary = asDictionary
        
        do {
            let theJSONData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: theJSONData, encoding: .ascii)
            
            return jsonString
        } catch let error {
            
            print("DS EncodableExtension | Error during converting to JSON string | \(error)")
            return nil
        }
    }
    
    var asQueryItems: [URLQueryItem] {
        
        let queryItems: [URLQueryItem] = asDictionary.map({
            
            if let value = $0.value as? String {
                return URLQueryItem(name: $0.key, value: value)
            } else {
                return nil
            }
        }).compactMap({ $0 })
        
        return queryItems
    }
}
