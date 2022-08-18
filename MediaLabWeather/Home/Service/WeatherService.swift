//
//  WeatherService.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import Foundation

protocol WeatherServiceProtocol: AnyObject {
    
    var appConfiguration: AppConfigurations { get }
    
    func fetchData(_ coord: Coordinates, completion: @escaping(Result<WeatherResult, Error>) -> Void)
}

class WeatherService {
    private let service: NetworkService
    let appConfiguration: AppConfigurations
    
    init(service: NetworkService = NetworkService(),
         appConfiguration: AppConfigurations = AppConfigurations()) {
        self.service = service
        self.appConfiguration = appConfiguration
    }
}

extension WeatherService: WeatherServiceProtocol {
    func fetchData(_ coord: Coordinates, completion: @escaping(Result<WeatherResult, Error>) -> Void) {
        let endpoint = WeatherEndpoint(lat: coord.lat, lon: coord.lon, units: .celsius, appConfiguration: self.appConfiguration)
        _ = service.request(for: endpoint.url, completion: completion)
    }
}
