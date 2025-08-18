//
//  ContentView.swift
//  Task 2 Interoper
//
//  Created by Artur Bednarz on 17/08/2025.
//

import SwiftUI

struct SwiftUIView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UserViewController {
        let vc = UserViewController()
        return vc
    }
    
    func updateUIViewController(_ vc: UserViewController, context: Context) { }
}

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Text("Hello, from SwiftUI!")
                .frame(width: 200, height: 50)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            SwiftUIView() //From UIKit
                .frame(width: 200, height: 50)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    ContentView()
}
