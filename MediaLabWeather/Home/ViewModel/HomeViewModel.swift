//
//  HomeViewModel.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchData(_ coord: Coordinates)
    
    var weather: Bindable<WeatherResult> { get set }
    var error: Bindable<Error> { get set }
}

class HomeViewModel {
    
    // MARK: - Private Properties
    let weatherService: WeatherRepositoryProtocol
    let coordinator: HomeCoordinator
    var weather = Bindable<WeatherResult>()
    var error = Bindable<Error>()
    // MARK: - Inits
    
    init(with service: WeatherRepositoryProtocol, coordinator: HomeCoordinator) {
        self.weatherService = service
        self.coordinator = coordinator
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
