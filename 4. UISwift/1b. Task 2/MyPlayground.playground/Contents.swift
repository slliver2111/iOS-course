import Combine
import Foundation

var cancellables = Set<AnyCancellable>()
let publisher = Future<String, Never> { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("Hello, Combine!")
    }
}

publisher
    .sink{ val in
        print(val)}
    .store(in: &cancellables)
