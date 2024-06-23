//
//  WeatherModel.swift
//  Weather
//
//  Created by Victoria on 19/06/2024.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    let condition: String

    var temperatureString: String {
        if temperature > 0 {
            return String(format: "+%.0f", temperature)
        } else if temperature < 0{
            return String(format: "-%.0f", temperature)
        }
        return String(format: "%.0f", temperature)
    }

    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
