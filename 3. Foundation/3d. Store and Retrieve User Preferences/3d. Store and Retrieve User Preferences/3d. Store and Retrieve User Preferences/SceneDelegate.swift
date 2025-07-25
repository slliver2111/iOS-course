//
//  SceneDelegate.swift
//  3d. Store and Retrieve User Preferences
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = UINavigationController(rootViewController: UserViewController())
        window?.makeKeyAndVisible()
    }
}

