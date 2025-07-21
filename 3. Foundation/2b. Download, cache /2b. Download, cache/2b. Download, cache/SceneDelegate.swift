//
//  SceneDelegate.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 11/07/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let networkManager = NetworkManager()
        let imageCacheManager = ImageCacheManager()
        let mainViewController = MainViewController(networkManager: networkManager, imageCacheManager: imageCacheManager)
        let navViewController = UINavigationController(rootViewController: mainViewController)
        
        self.window?.rootViewController = navViewController
        window?.makeKeyAndVisible()
    }

}

