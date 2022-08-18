//
//  AppDelegate.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var mainCoordinator: AppMainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        mainCoordinator = AppMainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
        window?.makeKeyAndVisible()
        
        return true
    }
}
