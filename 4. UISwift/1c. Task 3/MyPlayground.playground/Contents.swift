import Combine

let publisherName = Just("Artur")
    .map { $0.uppercased() }
let publisherSurname = Just("Bednarz")
    .map { $0.lowercased() }
    
let cancellabe = publisherName
    .combineLatest(publisherSurname)
    .map { "\($0) \($1)" }
    .sink { print($0) }
