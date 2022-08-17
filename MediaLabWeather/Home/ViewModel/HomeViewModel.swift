//
//  HomeViewModel.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Private Properties
    let weatherService: WeatherServiceProtocol
    var weather = Bindable<WeatherResult>()
    var error = Bindable<Error>()
    // MARK: - Inits
    
    init(with service: WeatherServiceProtocol) {
        self.weatherService = service
    }
    
    func fetchData(_ coord: Coordinates) {
        weatherService.fetchData(coord) { result in
            switch result {
            
            case .success(let weather):
                self.weather.value = weather
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
