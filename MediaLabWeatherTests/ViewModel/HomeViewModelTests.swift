//
//  HomeViewModelTests.swift
//  MediaLabWeatherTests
//
//  Created by Renato Mateus on 10/08/22.
//

import XCTest
@testable import MediaLabWeather

class HomeViewModelTests: XCTestCase {
    
    typealias Completion<T> = ((_ value: T) -> Void)
    var viewModel: HomeViewModel!
    var successCompletion: Completion<Any>!
    var failureCompletion: Completion<Any>!
    lazy var serviceMockSuccess: WeatherRepositoryMockSuccess = WeatherRepositoryMockSuccess()
    lazy var serviceMockFailure: WeatherRepositoryMockFailure = WeatherRepositoryMockFailure()
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func testFetchIfSuccess() {
        viewModel = HomeViewModel(with: serviceMockSuccess)
        viewModel.weather.bind { [unowned self] (_) in
            if let weather = self.viewModel.weather.value {
                self.successCompletion(weather)
            }
        }
        let expectation = XCTestExpectation.init(description: "Weather Data")
        self.successCompletion = { posts in
            XCTAssertNotNil(posts, .localized(.noDataDownloaded))
            expectation.fulfill()
        }
        viewModel.fetchData(Coordinates(lon: -22.0000, lat: 33.0000))
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testFetchPostsIfFailure() {
        viewModel = HomeViewModel(with: serviceMockFailure)
        viewModel.error.bind { [unowned self] (_) in
            if let error = self.viewModel.error.value {
                failureCompletion(error)
            }
        }
        let expectation = XCTestExpectation.init(description: "Error")
        self.failureCompletion = { error in
            XCTAssertNotNil(error, .localized(.noDataDownloaded))
            expectation.fulfill()
        }
        viewModel.fetchData(Coordinates(lon: -22.0000, lat: 33.0000))
        wait(for: [expectation], timeout: 60.0)
    }
}
