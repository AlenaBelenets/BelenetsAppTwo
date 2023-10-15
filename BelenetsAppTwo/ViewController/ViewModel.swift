//
//  ViewModel.swift
//  BelenetsAppTwo
//
//  Created by Alena Belenets on 10.10.2023.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay



// MARK: - ViewModelProtocol
protocol ViewModelProtocol {
    var cityName: String { get }
    var temp: String { get }
    var dataSource: [List] { get }
    func fetchWeather(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func fetchTown(townName: String )

}

// MARK: - ViewModel
class ViewModel: CLLocationManager, ViewModelProtocol, CLLocationManagerDelegate {

    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private var weathers: WeatherModel = WeatherModel(city: "", temp: 0.0, date: "", weatherList: [List]())
    private var weatherManager = NetworkManager()

    var dataSource: [List] {
        weathers.weatherList
    }

    var cityName: String {
        weathers.city
    }
    var temp: String {
        weathers.temperatureString
    }
    private let disposedBag = DisposeBag()

    // MARK: - Functions
    func fetchTown(townName: String) {
        weatherManager.fetchWeather(townName: townName)
    }

    func fetchWeather(completion: @escaping () -> Void) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.forecast.observe(on: MainScheduler.instance)
            .subscribe {  weathers in

                if let weathersElement = weathers.element {
                    self.weathers = WeatherModel(city: weathersElement.city, temp: weathersElement.temp, date: weathersElement.date, weatherList: weathersElement.weatherList)
                    
                    completion()
                }
            }
            .disposed(by: disposedBag)

    }
    
    func numberOfRows() -> Int {
        dataSource.count
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
        assert(true, "Can't load location")
    }

}

