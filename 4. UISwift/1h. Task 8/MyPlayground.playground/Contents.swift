import Combine

class ServiceManager {
    @Published var isLoading = false
}

var cancellables = Set<AnyCancellable>()

let service = ServiceManager()
service.$isLoading
    .removeDuplicates()
    .sink() { val in
        print("Loading changed. Current: \(val)")
    }
    .store(in: &cancellables)

service.isLoading = true
service.isLoading = true
service.isLoading = false
