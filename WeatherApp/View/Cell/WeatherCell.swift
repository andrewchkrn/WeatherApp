//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Andrew Trach on 13.02.2022.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    var weather: Daily! {
        didSet {
            configure(weather)
        }
    }
    
    func configure(_ item: Daily) {
        if let timeResult = (item.dt as? Int) {
            let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.full //Set date style
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            timeLabel.text = localDate
        }
        tempLabel.text = String((item.temp.day.exponent)) + "°C"
        guard let icon = item.weather.first?.icon else { return }
        imageView.image = UIImage(named: icon)
    }
}
