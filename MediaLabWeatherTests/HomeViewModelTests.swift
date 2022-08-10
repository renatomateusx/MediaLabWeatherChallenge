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
    lazy var serviceMockSuccess: WeatherServiceMockSuccess = WeatherServiceMockSuccess()
    lazy var serviceMockFailure: WeatherServiceMockFailure = WeatherServiceMockFailure()
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func testFetchIfSuccess() {
        viewModel = HomeViewModel(with: serviceMockSuccess)
        viewModel?.delegate = self
        let expectation = XCTestExpectation.init(description: "Weather Data")
        self.successCompletion = { posts in
            XCTAssertNotNil(posts, "No data was downloaded.")
            expectation.fulfill()
        }
        viewModel.fetchData(Coordinates(lon: -22.0000, lat: 33.0000))
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testFetchPostsIfFailure() {
        viewModel = HomeViewModel(with: serviceMockFailure)
        viewModel.delegate = self
        let expectation = XCTestExpectation.init(description: "Error")
        self.failureCompletion = { error in
            XCTAssertNotNil(error, "No data was downloaded.")
            expectation.fulfill()
        }
        viewModel.fetchData(Coordinates(lon: -22.0000, lat: 33.0000))
        wait(for: [expectation], timeout: 60.0)
    }
}

extension HomeViewModelTests: HomeViewModelDelegate {
    func onSuccessFetchingWeather(weather: WeatherResult) {
        successCompletion(weather)
    }
    
    func onFailureFetchingWeather(error: Error) {
        failureCompletion(error)
    }
}
