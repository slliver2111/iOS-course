import Combine
import Foundation

var cancellables = Set<AnyCancellable>()
let passthroughSubject = PassthroughSubject<String, Never>()
passthroughSubject
    .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
    .sink { print("Final: \($0)")}
    .store(in: &cancellables)


let simulator = ["H", "He", "Hel", "Hello"]
var timeInterval = 0.0

for typed in simulator {
    timeInterval += 0.5
    DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval, execute: {
        print("User typed: \(typed)")
        passthroughSubject.send(typed)
    })
}
