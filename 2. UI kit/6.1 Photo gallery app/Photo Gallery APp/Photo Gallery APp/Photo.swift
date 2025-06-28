//
//  Photo.swift
//  Photo Gallery App
//
//  Created by Artur Bednarz on 28/06/2025.
//

import UIKit
import Foundation

struct Photo {
    let title: String
    let date: Date
    var isFavorite: Bool = false
    let image: UIImage?
    
    static func createExampleArray() -> [Self] {
        var newArrayOfPhotos: [Self] = []
        for i in 1...6 {
            let newPhoto = Photo(title: String(i), date: Date.now, isFavorite: false, image: UIImage(named: String(i)))
            newArrayOfPhotos.append(newPhoto)
            
        }
        for i in 7...11 {
            let newPhoto = Photo(title: String(i), date: Calendar.current.date(from: DateComponents(year: 2022))!, isFavorite: false, image: UIImage(named: String(i)))
            newArrayOfPhotos.append(newPhoto)
            
        }
        return newArrayOfPhotos
    }
}
