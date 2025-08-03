import Combine

var cancellables = Set<AnyCancellable>()
let subject = PassthroughSubject<Int, Never>()
    
subject
    .filter { $0 % 2 == 0 }
    .sink { print($0) }
    .store(in: &cancellables)

subject.send(0)
subject.send(1)
subject.send(66)
subject.send(67)
