//
//  WeatherCellViewModel.swift
//  WeatherApp
//
//  Created by Andrew Trach on 15.02.2022.
//

import Foundation

struct WeatherCellViewModel {
    
    private let daily: Daily
    
    // MARK: - Output
    var iconName: String?
    let time: String
    let temp: String
    
    init(_ daily: Daily) {
        self.daily = daily
        let timeResult = daily.dt
        let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.full //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        self.time = localDate
        self.temp = String((daily.temp.day.exponent)) + "°C"
        guard let icon = daily.weather.first?.icon else { return }
        self.iconName = icon
    }
}
