//
//  SceneDelegate.swift
//  Combine Task 9
//
//  Created by Artur Bednarz on 04/08/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
    }


}

