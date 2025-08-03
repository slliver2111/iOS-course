import Combine

let publisher = Just("Hello, Combine!")
let subscription = publisher
    .sink{ val in
        print(val)}
