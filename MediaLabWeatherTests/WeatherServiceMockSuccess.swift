//
//  WeatherServiceMockSuccess.swift
//  MediaLabWeatherTests
//
//  Created by Renato Mateus on 10/08/22.
//

import Foundation

@testable import MediaLabWeather

class WeatherServiceMockSuccess: WeatherServiceProtocol {
    var appConfiguration: AppConfigurations = AppConfigurations()
    
    func fetchData(_ coord: Coordinates, completion: @escaping (Result<WeatherResult, Error>) -> Void) {
        let fakeDataModel: WeatherResult = WeatherResult(coord: Coord(lon: -222.0, lat: 222.0),
                                                         weather: [Weather(id: 0, main: "main", weatherDescription: "weatherDescription", icon: "10d")],
                                                         base: "base", main: Main(temp: 22.0, feelsLike: 25.0, tempMin: 20.0, tempMax: 27.0, pressure: 15, humidity: 20),
                                                         visibility: 001, wind: Wind(speed: 20.0, deg: 01),
                                                         clouds: Clouds(all: 0), dt: 0, sys: Sys(type: 0, id: 0, country: "BR", sunrise: 0, sunset: 20), timezone: 0, id: 0, name: "Santa Mônica", message: nil)
        completion(.success(fakeDataModel))
    }
}
