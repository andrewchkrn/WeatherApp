//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Andrew Trach on 12.02.2022.
//


import UIKit
import GooglePlaces
import CoreLocation

final class WeatherVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel = WeatherViewModel()
    private var tableView: UITableView!
    private var tableDataSource: GMSAutocompleteTableDataSource!
    private let reuseIdentifierCell = "WeatherCell"
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAutocomplete()
        observeSignals()
        configureUI()
    }
    
    // MARK: - @IBAction func
    
    @IBAction private func closeSearchAction(_ sender: Any) {
        viewModel.closeSearchAction()
        hideautocompleteTableView()
    }
    
    // MARK: - Private func
    
    private func configureUI() {
        self.dateLabel.text = Date.getTodaysDate()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func observeSignals() {
        viewModel.searchTextSignal = { [weak self] text in
            self?.searchTextField.text = text
        }
        
        viewModel.cityTextSignal = { [weak self] text in
            self?.cityLabel.text = text
        }
        
        viewModel.iconNameSignal = { [weak self] icon in
            self?.imageView.image = UIImage(named: icon)
        }
        
        viewModel.weatherDescriptionSignal = { [weak self] text in
            self?.weatherLabel.text = text
        }
        
        viewModel.reloadDataSignal = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
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

extension WeatherVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDidChange(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension WeatherVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCell, for: indexPath) as! WeatherCell
        
        if let vm = viewModel.viewModelFor(indexPath.row) {
            cell.configure(vm)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
}

// MARK: - GMSAutocompleteTableDataSourceDelegate

extension WeatherVC: GMSAutocompleteTableDataSourceDelegate {
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
        viewModel.didAutocompliteWithPlace(place: place)
        hideautocompleteTableView()
        view.endEditing(true)
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")
        tableView.removeFromSuperview()
    }
}
