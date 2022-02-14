//
//  Global Functions.swift
//  Weather
//
//  Created by Andrew Trach on 12.02.2022.
//

import UIKit

extension Date {
    
    static func getTodaysDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
}
