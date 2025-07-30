//
//  SceneDelegate.swift
//  3e. Simple Login Persistence System
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            showMainScreen()
        } else {
            showLoginScreen()
        }
        
        window?.makeKeyAndVisible()
    }
    
    func showMainScreen() {
        let mainVC = MainViewController()
        window?.rootViewController = UINavigationController(rootViewController: mainVC)
    }
    
    func showLoginScreen() {
        let loginVC = LoginViewController()
        window?.rootViewController = UINavigationController(rootViewController: loginVC)
    }
}

