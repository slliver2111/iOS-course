import Foundation

actor Counter {
    var value = 0
    
    func increment() {
        value += 1
    }
}

func runCounterTask() async {
    let counter = Counter()
    
    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            for _ in 1...1000 {
                await counter.increment()
            }
        }
        
        group.addTask {
            for _ in 1...1000 {
                await counter.increment()
            }
        }
    }
    
    let finalValue = await counter.value
    print("Final counter value: \(finalValue) (Expected: 2000)")
}

Task {
    await runCounterTask()
}
