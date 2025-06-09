//
//  SceneDelegate.swift
//  Calculator App
//
//  Created by Artur Bednarz on 05/06/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create a new window
        let window = UIWindow(windowScene: windowScene)

        // Create an instance of your ViewController
        let viewController = ViewController()

        // Set the root view controller and make the window visible
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
