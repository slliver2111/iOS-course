import Combine

let subject = PassthroughSubject<Int, Never>()
let filteredSubject = subject.filter { $0 % 2 == 0 }
var cancellables = filteredSubject.sink {val in print(val)}


subject.send(0)
subject.send(1)
subject.send(66)
subject.send(67)
