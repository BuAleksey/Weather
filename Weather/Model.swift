//
//  Model.swift
//  Weather
//
//  Created by Buba on 12.04.2022.
//

import Foundation

struct SerchWeather: Codable {
    let coord: Coord
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Coord: Codable {
    let lon, lat: Double
}

struct Main: Codable {
    let temp: Double
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    let feelsLike: Double
    var feelsLikeString: String {
        return String(format: "%.1f", feelsLike)
    }
    enum CodingKeys: String, CodingKey {
        
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
    var idString: String {
        switch id {
        case 200...232: return "storm"
        case 300...321: return "storm-2"
        case 500...531: return "rain"
        case 600...622: return "snowy"
        case 701...781: return "fog"
        case 800: return "sun"
        case 801...804: return "cloudy"
        default: return "nothing"
        }
    }
    var idEmoji: String {
        switch id {
        case 200...232: return "☔️"
        case 300...321: return "☂️"
        case 500...531: return "💧"
        case 600...622: return "❄️"
        case 701...781: return "🌫"
        case 800: return "☀️"
        case 801...804: return "☁️"
        default: return ""
        }
    }
}
