//
//  SceneDelegate.swift
//  Multi-tab app
//
//  Created by Artur Bednarz on 15/06/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        
        let obVC = OnboardingViewController()
        obVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        let settingVC = UIViewController()
        settingVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        
        let tbController = UITabBarController()
        tbController.viewControllers = [obVC, profileVC, settingVC]

        window.rootViewController = tbController
        self.window = window
        window.makeKeyAndVisible()
    }
}

