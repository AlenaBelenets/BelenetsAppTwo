//
//  NetworkManager.swift
//  BelenetsAppTwo
//
//  Created by Alena Belenets on 09.10.2023.
//

import Foundation
import RxSwift
import RxRelay
import CoreLocation


struct NetworkManager {
    var forecast = PublishRelay<WeatherModel>()

    private let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=47de623cf5a6ecf5503a226fa97dd2af&units=metric"

    func fetchWeather(townName: String) {
        let urlString = "\(weatherURL)&q=\(townName)"
        performRequest(with: urlString)
    }

    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }

    private func performRequest(with urlString: String) {
        if let fixedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if  let url = URL(string: fixedURLString) {
                let session = URLSession(configuration: .default)

                let task = session.dataTask(with: url) { data, _, error in
                    if error != nil {
                        print("Can't find data")
                        return
                    }
                    if let safeData = data {
                        if let weather = self.parseJSON(safeData) {
                            forecast.accept(weather)
                        }
                    }
                }
                task.resume()
            }
        }
    }

    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)

            let temp = decodedData.list[0].main.temp
            let cityName = decodedData.city.name
            let date = String(decodedData.list[0].dt)
            let list = decodedData.list

            let weather = WeatherModel(city: cityName,
                                       temp: temp,
                                       date: date,
                                       weatherList: list
            )
            return weather
        } catch {
            assert(true, "Can't load data")
            return nil
        }
    }
}



