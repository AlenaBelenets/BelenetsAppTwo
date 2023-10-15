//
//  Wea.swift
//  BelenetsAppTwo
//
//  Created by Alena Belenets on 08.10.2023.
//

import Foundation

struct WeatherModel {
    let city: String
    let temp: Double
    let date: String
    let weatherList: [List]

    var temperatureString: String {
        return String(format: "%.1f", temp)
    }
}

struct List: Codable {
    let main: Main
    let dt: Int
}

struct Main: Codable {
    let temp: Double
}

struct Town: Codable {
    let name: String
}

struct WeatherData: Codable {
    let list: [List]
    let city: Town
}


