//
//  OpenWeather.swift
//
//  Created by Andrew Trach on 12.02.2022.
//


import Foundation

// MARK: - OpenWeather
struct OpenWeather: Codable {
    let current: Current
    var daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case current
        case daily
    }
}

// MARK: - Current
struct Current: Codable {
    let temp: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case  temp
        case weather
    }
}


// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let icon, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case id, icon
        case weatherDescription = "description"
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case  dt, temp
        case weather
    }
}

// MARK: - Temp
struct Temp: Codable {
    let night, min, eve, day: Double
    let max, morn: Double
}

