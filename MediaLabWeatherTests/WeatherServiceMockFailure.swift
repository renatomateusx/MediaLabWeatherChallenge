//
//  WeatherServiceMockFailure.swift
//  MediaLabWeatherTests
//
//  Created by Renato Mateus on 10/08/22.
//

import Foundation
@testable import MediaLabWeather

class WeatherServiceMockFailure: WeatherServiceProtocol {
    var appConfiguration: AppConfigurations = AppConfigurations()
    
    func fetchData(_ coord: Coordinates, completion: @escaping (Result<WeatherResult, Error>) -> Void) {
        completion(.failure(NSError(domain: "No data was downloaded.",
                                    code: 400,
                                    userInfo: nil)))
    }
}
