//
//  SceneDelegate.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windoeScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windoeScene.coordinateSpace.bounds)
        window?.windowScene = windoeScene
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
        
    }
}

