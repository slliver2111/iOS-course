import Combine

let subject = PassthroughSubject<Int, Never>()
    
let cancellabe = subject
    .filter { $0 % 2 == 0 }
    .sink { print($0) }

subject.send(0)
subject.send(1)
subject.send(66)
subject.send(67)
