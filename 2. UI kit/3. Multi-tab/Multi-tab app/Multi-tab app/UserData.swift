//
//  UserData.swift
//  Multi-tab app
//
//  Created by Artur Bednarz on 22/06/2025.
//

import Foundation

class UserData {
    var name = ""
    var phoneNumber = ""
    let defaultNotificationPreference = PreferencesViewController.UserNotificationPreference.Push
    var notificationPreference: PreferencesViewController.UserNotificationPreference
    var onBoardingFinished = false
    
    init() {
        self.notificationPreference = defaultNotificationPreference
    }
    
    func reset() {
        name = ""
        phoneNumber = ""
        notificationPreference = defaultNotificationPreference
    }
}
