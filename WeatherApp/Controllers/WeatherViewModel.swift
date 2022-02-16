//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Andrew Trach on 15.02.2022.
//

import Foundation
import UIKit
import GooglePlaces

class WeatherViewModel {
    
    private var locationService = LocationService()
    private let apiService = ApiServise()
    private var openWeather: OpenWeather?
    
    // MARK: Outputs
    
    var searchTextSignal: ((String?) -> Void)?
    var cityTextSignal: ((String?) -> Void)?
    var iconNameSignal: ((String) -> Void)?
    var weatherDescriptionSignal: ((String) -> Void)?
    var reloadDataSignal: (() -> Void)?
    
    init() {
        locationService.getLocation()
        observeLocationManager()
    }
    
    func viewModelFor(_ index: Int) -> WeatherCellViewModel? {
        if let daily = openWeather?.daily[index] {
            let vm = WeatherCellViewModel(daily)
            return vm
        }
        return nil
    }
    
    func numberOfItems() -> Int {
        return openWeather?.daily.count ?? 0
    }
    
    // MARK: Inputs
    
    func closeSearchAction() {
        searchTextSignal?("")
    }
    
    func didAutocompliteWithPlace(place: GMSPlace) {
        let latitude = CGFloat(place.coordinate.latitude)
        let longitude = CGFloat(place.coordinate.longitude)
        searchTextSignal?(place.name)
        cityTextSignal?(place.name)
        getWeather(lat: latitude, lon: longitude)
    }
    
    // MARK: - Private func
    
    private func observeLocationManager() {
        locationService.currentLocationSignal = { [weak self] (coordinate) in
            if let coordinate = coordinate?.coordinate {
                self?.getWeather(lat: coordinate.latitude, lon: coordinate.longitude)
            }
        }
        
        locationService.currentCitySignal = { [weak self] (place) in
            if let place = place {
                self?.searchTextSignal?(place)
                self?.cityTextSignal?(place)
            }
        }
    }
    
    private func getWeather(lat: CGFloat, lon: CGFloat) {
        let openWeatherForm = OpenWeatherForm(lat: lat, lon: lon)
        apiService.getWeather(form: openWeatherForm) { [self] (result) in
            switch result {
            case .success(let model):
                handleSuccess(model)
            case .failure(_): break
            }
        }
    }
    
    private func handleSuccess(_ data: OpenWeather) {
        self.openWeather = data
        reloadDataSignal?()
        if let weather = data.current.weather.first {
            iconNameSignal?(weather.icon)
            weatherDescriptionSignal?(weather.weatherDescription)
        }
    }
}
