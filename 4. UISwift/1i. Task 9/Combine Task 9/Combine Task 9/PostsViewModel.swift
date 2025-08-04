//
//  File.swift
//  Combine Task 9
//
//  Created by Artur Bednarz on 04/08/2025.
//

import Combine
import Foundation

class PostsViewModel {
    @Published var posts: [Post] = []
    private var cancellables = Set<AnyCancellable>()
    private var url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    func fetchPosts() {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.posts, on: self)
            .store(in: &cancellables)
    }
}
