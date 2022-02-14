//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrew Trach on 12.02.2022.
//


import UIKit
import GooglePlaces

import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var tableView: UITableView!
    private var tableDataSource: GMSAutocompleteTableDataSource!
    private let api: ApiServiseProtocol = ApiServise()
    private var weatherData: OpenWeather?
    private var locationService = LocationService(updateLocation: true)
    private var currentlocation: CLLocation! {
        didSet {
            getWeather(lat: currentlocation.coordinate.latitude, lon: currentlocation.coordinate.longitude)
        }
    }
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAutocomplete()
        locationManagerComplete()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - @IBAction func
    
    @IBAction func closeSearchAction(_ sender: Any) {
        searchTextField.text = ""
        hideautocompleteTableView()
    }
    
    // MARK: - Private func
    
    private func locationManagerComplete() {
        locationService.getWeatherHadler = { [weak self] (coordinate) in
            self?.currentlocation = coordinate
            if let coordinate = coordinate?.coordinate {
                self?.getWeather(lat: coordinate.latitude, lon: coordinate.longitude)
            }
        }
        locationService.currentCityHadler = { [weak self] (place) in
            if let place = place {
                self?.searchTextField.text = place
                self?.cityLabel.text = place
            }
        }
    }
    
    private func getWeather(lat: CGFloat, lon: CGFloat) {
        let openWeatherForm = OpenWeatherForm(lat: lat, lon: lon)
        api.getWeather(form: openWeatherForm) { [self] (result) in
            switch result {
            case .success(var model):
                print(model.current.weather)
                self.imageView.image = UIImage(named: model.current.weather[0].icon)
                self.dateLabel.text = Date.getTodaysDate()
                self.weatherLabel.text = model.current.weather[0].weatherDescription.uppercased()
                model.daily.removeFirst()
                self.weatherData = model
                self.collectionView.reloadData()
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        tableView.frame = CGRect(x: 0, y: searchTextField.frame.maxY, width: view.frame.width, height: view.frame.height )
        tableDataSource.sourceTextHasChanged(textField.text)
        view.addSubview(tableView)
    }
    
    private func configureAutocomplete() {
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self
        tableView = UITableView(frame: .zero)
        tableView.delegate = tableDataSource
        tableView.dataSource = tableDataSource
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
}


// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDidChange(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        if let item = weatherData?.daily[indexPath.row] {
            cell.configure(item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let days = weatherData?.daily.count else { return 0 }
        return days
    }
}

// MARK: - GMSAutocompleteTableDataSourceDelegate

extension ViewController: GMSAutocompleteTableDataSourceDelegate {
    private func hideautocompleteTableView() {
        tableView.removeFromSuperview()
        view.endEditing(true)
    }
    
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        tableView.reloadData()
    }
    
    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        tableView.reloadData()
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        let latitude = CGFloat(place.coordinate.latitude)
        let longitude = CGFloat(place.coordinate.longitude)
        searchTextField.text = place.name
        cityLabel.text = place.name
        getWeather(lat: latitude, lon: longitude)
        hideautocompleteTableView()
        view.endEditing(true)
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")
        tableView.removeFromSuperview()
    }
}
