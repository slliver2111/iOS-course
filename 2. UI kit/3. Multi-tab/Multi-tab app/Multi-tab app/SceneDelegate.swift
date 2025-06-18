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
        let obNC = UINavigationController(rootViewController: obVC)
        obNC.tabBarItem = UITabBarItem(title: "Onboarding", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let profileVC = ProfileViewController()
        let profileNC = UINavigationController(rootViewController: profileVC)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        let settingVC = UIViewController()
        settingVC.title = "Settings are easy!"
        settingVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear.fill"))
        
        let tabbVC = UITabBarController()
        tabbVC.viewControllers = [obNC, profileNC, settingVC]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange

        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        tabbVC.tabBar.scrollEdgeAppearance = appearance

        window.rootViewController = tabbVC
        self.window = window
        window.makeKeyAndVisible()
    }
}

