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
    
    var window: UIWindow!
    private var mainCoordinator: AppMainCoordinator?
    
    override func setUp() {
        super.setUp()
        
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        guard let firstWindow = firstScene.windows.first else {
            return
        }
        
        window = firstWindow
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        mainCoordinator = AppMainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
        window.makeKeyAndVisible()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialState() {
        sleep(3)
        if let vc =  mainCoordinator?.navigationController.viewControllers.first {
            assertSnapshot(matching:vc, as: .image(precision: 0.99))
        }
    }
}
