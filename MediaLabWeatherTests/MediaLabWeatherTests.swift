//
//  MediaLabWeatherTests.swift
//  MediaLabWeatherTests
//
//  Created by Renato Mateus on 17/08/22.
//

import XCTest
import UIKit
import SnapshotTesting

@testable import MediaLabWeather

class MediaLabWeatherTests: XCTestCase {
    
    var viewController: HomeViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        
        viewController = HomeViewController()
        viewController.viewModel = HomeViewModel(with: WeatherServiceMockSuccess())
        viewController.loadViewIfNeeded()
        
        window = UIApplication.shared.windows.first
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialState() {
        sleep(3)
        
        assertSnapshot(matching: viewController, as: .image(precision: 0.99))
    }
}
