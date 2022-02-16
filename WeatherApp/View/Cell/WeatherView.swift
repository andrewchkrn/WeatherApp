//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Andrew Trach on 16.02.2022.
//

import UIKit

final class WeatherView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configure(_ viewModel: WeatherCellViewModel) {
        timeLabel.text = viewModel.time
        tempLabel.text = viewModel.temp
        if let icon = viewModel.iconName {
            imageView.image = UIImage(named: icon)
        }
    }
}
