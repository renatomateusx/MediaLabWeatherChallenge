//
//  AppMainCoordinator.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 18/08/22.
//

import UIKit

class AppMainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
