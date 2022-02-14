//
//  LocationService.swift
//  WeatherApp
//
//  Created by Andrew Trach on 12.02.2022.
//

import Foundation
import CoreLocation


class LocationService: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var getWeatherHadler: ((CLLocation?) -> Void)?
    var currentCityHadler: ((String?) -> Void)?
    
    init(updateLocation: Bool = true) {
        super.init()
        if updateLocation {
            getLocation()
        }
    }
    
     func getLocation() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentLocation = location
            locationManager.stopUpdatingLocation()
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let placemark = placemarks[0]
                        if let city = placemark.locality {
                            self.currentCityHadler?(city)
                        }
                    }
                }
            }
            self.getWeatherHadler?(currentLocation)
        }
    }
   
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
}
