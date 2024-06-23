//
//  WeatherViewController.swift
//  Weather
//
//  Created by Victoria on 16/06/2024.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var conditionDescription: UILabel!

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}

extension WeatherViewController: UITextFieldDelegate {

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type city name"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

extension WeatherViewController: WeatherManagerDelegate {

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {

        DispatchQueue.main.async {
            self.temperature.text = weather.temperatureString
            self.imageWeather.image = UIImage(systemName: weather.conditionName)
            self.city.text = weather.cityName
            self.conditionDescription.text = weather.condition.description.capitalized
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}


extension WeatherViewController: CLLocationManagerDelegate {

    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

