import Combine

let publisher = Just("Hello, Combine!")

let cancellabe = publisher
    .sink{ val in
        print(val)}
