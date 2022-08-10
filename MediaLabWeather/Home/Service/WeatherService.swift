//
//  WeatherService.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import Foundation

protocol WeatherServiceProtocol: AnyObject {
    func fetchData(_ coord: Coordinates, completion: @escaping(Result<WeatherResult, Error>) -> Void)
}

class WeatherService {
    private var service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
}

extension WeatherService: WeatherServiceProtocol {
    func fetchData(_ coord: Coordinates, completion: @escaping(Result<WeatherResult, Error>) -> Void) {
        let endpoint = WeatherEndpoint(lat: coord.lat, lon: coord.lon, units: .celsius)
        _ = service.request(for: endpoint.url, completion: completion)
    }
}
