//
//  OpenWeatherForm.swift
//  NetworikngManager
//
//  Created by Andrew Trach on 12.02.2022.
//

import Foundation

//MARK: - OpenWeatherForm
final class OpenWeatherForm: Encodable {
    
    // MARK: - Types
    
    private enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lon = "lon"
        case units = "units"
        case appid = "appid"
    }
    
    // MARK: - Properties
    
    private(set) var lat: Double
    private(set) var lon: Double
    private(set) var units: String = "metric"
    private(set) var appid: String = "302e191e99e95526eb0573f8af51d5b9"
    
    // MARK: - Initialization
    
    init(lat: Double, lon: Double) {
        
        self.lat = lat
        self.lon = lon
    }
    
    // MARK: - Encoding
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
        try container.encode(units, forKey: .units)
        try container.encode(appid, forKey: .appid)
        
    }
}
