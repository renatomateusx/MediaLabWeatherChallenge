//
//  WeatherEndPoint.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import Foundation

enum Metrics {
    case celsius
    case fahrenheit
    
    var description: String {
        switch(self) {
        case .celsius:
            return "metric"
        case .fahrenheit:
            return "imperial"
        }
    }
}

struct WeatherEndpoint {
    let lat: Double
    let lon: Double
    let units: Metrics
    let appConfiguration: AppConfigurations

    var host: String {
        return appConfiguration.apiBaseURL
    }
    
    var appId: String {
        return appConfiguration.apiKey
    }

    var path: String {
        return "weather?lat=\(lat)&lon=\(lon)&appId=\(appId)&units=\(units.description)"
    }
    
    var url: URL {
        return URL(string: "\(host)\(path)")!
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
