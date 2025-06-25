//
//  GymClass.swift
//  5. Gym Schedule App
//
//  Created by Artur Bednarz on 22/06/2025.
//

import Foundation
import UIKit

struct GymClass{
    let name: String
    let day: Date
    let time: DateComponents
    let duration: Int = 60
    let trainer: Trainer
    var isRegistered: Bool = false
    
    static public func loadExampleData() -> [GymClass] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        func makeClass(name: String, daysFromNow: Int, hour: Int, minute: Int, trainer: Trainer, isRegistered: Bool) -> GymClass {
            let day = calendar.date(byAdding: .day, value: daysFromNow, to: today)!
            let time = DateComponents(hour: hour, minute: minute)
            return GymClass(name: name, day: day, time: time, trainer: trainer, isRegistered: isRegistered)
        }
    
        
        let trainer1 = Trainer(name: "Kasia", photo: UIImage(named: "Kasia"))
        let trainer2 = Trainer(name: "Ola", photo: nil)
    
        return [
            makeClass(name: "Yoga", daysFromNow: 1, hour: 10, minute: 0, trainer: trainer1, isRegistered: true),
            makeClass(name: "Crossfit", daysFromNow: 1, hour: 12, minute: 0, trainer: trainer2, isRegistered: false),
            makeClass(name: "Karate", daysFromNow: 3, hour: 9, minute: 0, trainer: trainer2, isRegistered: false),
            makeClass(name: "Pump", daysFromNow: 4, hour: 8, minute: 0, trainer: trainer1, isRegistered: true),
        ]
    }
}
