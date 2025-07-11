//
//  SceneDelegate.swift
//  Top Rated Movies
//
//  Created by Artur Bednarz on 07/07/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let networkManager = NetworkManager()
        let movieViewController = ViewController(networkManager: networkManager)
        
        self.window?.rootViewController = UINavigationController(rootViewController: movieViewController)
        window?.makeKeyAndVisible()
    }
    
}

