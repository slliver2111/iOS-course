//
//  SceneDelegate.swift
//  5. Gym Schedule App
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var arrayOfGymClass: [GymClass] = []
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        //print(GymClass.arrayOfGymClass)
        
        window.rootViewController = GymClassesViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
}
