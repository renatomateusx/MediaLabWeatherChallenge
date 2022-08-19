//
//  WeatherRepository.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import Foundation

protocol WeatherRepositoryProtocol: AnyObject {
    
    var appConfiguration: AppConfigurations { get }
    
    func fetchData(_ coord: Coordinates, completion: @escaping(Result<WeatherResult, Error>) -> Void)
}

class WeatherRepository {
    private let service: NetworkRepository
    let appConfiguration: AppConfigurations
    
    init(service: NetworkRepository = NetworkRepository(),
         appConfiguration: AppConfigurations = AppConfigurations()) {
        self.service = service
        self.appConfiguration = appConfiguration
    }
}

extension WeatherRepository: WeatherRepositoryProtocol {
    func fetchData(_ coord: Coordinates, completion: @escaping(Result<WeatherResult, Error>) -> Void) {
        let endpoint = WeatherEndpoint(lat: coord.lat, lon: coord.lon, units: .celsius, appConfiguration: self.appConfiguration)
        _ = service.request(for: endpoint.url, completion: completion)
    }
}
