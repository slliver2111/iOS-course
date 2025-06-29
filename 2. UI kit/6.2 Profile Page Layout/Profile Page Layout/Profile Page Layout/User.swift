//
//  User.swift
//  Profile Page Layout
//
//  Created by Artur Bednarz on 29/06/2025.
//

import UIKit

struct User {
    let name: String
    let photo: UIImage?
    let bio: String
    let followerCount: Int
    let followingCount: Int
    let postsCount: Int
    
    static func hardCodeExampleUser() -> Self {
        let name: String = "Aleksandra Kinga"
        let bio: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ullamcorper ex in metus imperdiet egestas. Nam pellentesque id velit et rhoncus. Vestibulum mollis massa id consectetur rhoncus. Lorem ipsum dolor sit amet, conse."
        
        
        return User(name: name, photo: UIImage(named: "Ola"), bio: bio, followerCount: 128, followingCount: 23, postsCount: 0)
    }
 }
