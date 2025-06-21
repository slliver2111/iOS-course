//
//  SceneDelegate.swift
//  4. Image Display
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = ViewControllerTransparent()
        self.window = window
        window.makeKeyAndVisible()
    }
}
