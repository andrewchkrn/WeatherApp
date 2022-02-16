//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Andrew Trach on 13.02.2022.
//

import UIKit

final class WeatherCell: UICollectionViewCell {
    
    @IBOutlet private weak var weatherView: WeatherView!
    
    func configure(_ viewModel: WeatherCellViewModel) {
        weatherView.configure(viewModel)
    }
}
