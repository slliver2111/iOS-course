//
//  SceneDelegate.swift
//  Profile Page Layout
//
//  Created by Artur Bednarz on 29/06/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = ViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
}
