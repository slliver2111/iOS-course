//
//  ViewController.swift
//  3c. Broadcast App State Changes
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class myViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func appDidEnterBackground(notification: Notification) {
        print("App entered background")
    }
    
    @objc func appDidBecomeActive(notification: Notification) {
        print("App became active")
    }
}

