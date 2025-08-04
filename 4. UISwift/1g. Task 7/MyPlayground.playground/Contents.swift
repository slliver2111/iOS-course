import Combine

class ViewModel {
    let button = PassthroughSubject<Void, Never>()
    var counter = 0
    var cancellables = Set<AnyCancellable>()
    
    init() {
        button
            .sink { [weak self] in
                guard let self = self else {return}
                self.counter += 1
                print("Button tapped! Counter: \(self.counter)")
            }
            .store(in: &cancellables)
    }
}

let viewModel1 = ViewModel()
viewModel1.button.send()
viewModel1.button.send()
viewModel1.button.send()

