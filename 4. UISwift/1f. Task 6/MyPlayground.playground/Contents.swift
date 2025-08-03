import Combine

var canellables = Set<AnyCancellable>()
let passThroughtSubject = PassthroughSubject<Int, Never>()

passThroughtSubject
    .flatMap { number -> Just<Int> in
        return Just(number * number)
    }
    .sink { squared in
        print(squared)
    }
    .store(in: &canellables)

passThroughtSubject.send(2)
passThroughtSubject.send(3)
passThroughtSubject.send(5)
passThroughtSubject.send(10)
