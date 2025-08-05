import Combine

var cancellables = Set<AnyCancellable>()
let publisherName = Just("Artur")
    .map { $0.uppercased() }
let publisherSurname = Just("Bednarz")
    
publisherName
    .combineLatest(publisherSurname)
    .map { "\($0) \($1)" }
    .sink { print($0) }
    .store(in: &cancellables)
