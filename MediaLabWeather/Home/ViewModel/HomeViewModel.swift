//
//  HomeViewModel.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func onSuccessFetchingWeather(weather: WeatherResult)
    func onFailureFetchingWeather(error: Error)
}

class HomeViewModel {
    
    // MARK: - Private Properties
    let weatherService: WeatherServiceProtocol
    var delegate: HomeViewModelDelegate?
    // MARK: - Inits
    
    init(with service: WeatherServiceProtocol) {
        self.weatherService = service
    }
    
    func fetchData(_ coord: Coordinates) {
        weatherService.fetchData(coord) { result in
            switch result {
            
            case .success(let weather):
                self.delegate?.onSuccessFetchingWeather(weather: weather)
            case .failure(let error):
                self.delegate?.onFailureFetchingWeather(error: error)
            }
        }
    }
}
