import Combine
import Foundation

let publisher = Future<String, Never> { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("Hello, Combine!")
    }
}

let cancellabe = publisher
    .sink{ val in
        print(val)}
