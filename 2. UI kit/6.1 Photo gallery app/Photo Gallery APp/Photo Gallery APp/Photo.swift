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
        for i in 1...20 {
            let newPhoto = Photo(title: String(i), date: Date.now, isFavorite: false, image: UIImage(named: String(i)))
            newArrayOfPhotos.append(newPhoto)
            
        }
        return newArrayOfPhotos
    }
}
