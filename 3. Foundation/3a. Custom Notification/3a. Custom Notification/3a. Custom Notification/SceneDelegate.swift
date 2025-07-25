//
//  SceneDelegate.swift
//  3a. Custom Notification
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        
        let senderVC = SenderViewController()
        let receiverVC = ReceiverViewController()
        
        let tabC = UITabBarController()
        tabC.viewControllers = [
            UINavigationController(rootViewController: senderVC),
            UINavigationController(rootViewController: receiverVC)
        ]
        
        senderVC.tabBarItem = UITabBarItem(title: "Sender", image: UIImage(systemName: "paperplane"), tag: 0)
        receiverVC.tabBarItem = UITabBarItem(title: "Receiver", image: UIImage(systemName: "arrow.down.document"), tag: 1)
        
        let _ = receiverVC.view
        
        window?.rootViewController = tabC
        window?.makeKeyAndVisible()
    }
}

