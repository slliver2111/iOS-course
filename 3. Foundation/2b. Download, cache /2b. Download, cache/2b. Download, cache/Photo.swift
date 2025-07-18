//
//  Photo.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 12/07/2025.
//

import UIKit

//MARK: Model
struct Photo: Codable {
    let id: String
    let urls: PhotoURLs
}

struct PhotoURLs: Codable {
    let regular: URL
}
