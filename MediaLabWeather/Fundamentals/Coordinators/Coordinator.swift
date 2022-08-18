//
//  Coordinator.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 18/08/22.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
