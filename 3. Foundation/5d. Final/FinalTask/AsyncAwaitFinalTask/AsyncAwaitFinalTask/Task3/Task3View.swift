//
//  Task3View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 05/07/2024.
//

import SwiftUI

struct Task3View: View {
    @State var currentStrength: Task3API.SignalStrenght = .unknown
    @State var running: Bool = false
    
    let api = Task3API()
    
    var body: some View {
        VStack {
            HStack {
                Text("Current signal strength: \(currentStrength)")
            }
            Button {
                if running {
                    running.toggle()
                    api.cancel()
                } else {
                    running.toggle()
                    Task {
                        let stream = api.signalStrength()
                        for await strength in stream {
                            currentStrength = strength
                        }
                        currentStrength = .unknown
                        print("stream finished")
                    }
                }
            } label: {
                if running {
                    Text("Cancel")
                } else {
                    Text("Start monitoring")
                }
            }
            
        }
    }
}

class Task3API {
    enum SignalStrenght: String {
        case weak, strong, excellent, unknown
    }
    private var signalTask: Task<Void, Never>?
    
    func signalStrength() -> AsyncStream<SignalStrenght> {
        let stream = AsyncStream<SignalStrenght> { continuation in
            self.signalTask = Task {
                while !Task.isCancelled {
                    do {
                        try await Task.sleep(for: .seconds(1))
                        continuation.yield([.weak, .strong, .excellent].randomElement() ?? .unknown)
                    } catch {
                        break
                    }
                }
                continuation.finish()
            }
        }
        return stream
    }
    
    
    func cancel() {
        signalTask?.cancel()
        signalTask = nil
    }
}

#Preview {
    Task3View()
}
