//
//  ContentView.swift
//  Task 3
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

struct ParentView: View {
    @State private var isBlue = true
    
    var body: some View {
        VStack(spacing: 16) {
            Rectangle()
                .fill(isBlue ? .blue : .red)
                .frame(width: 100, height: 150)
            ChildView(isBlue: $isBlue)
        }
        .padding()
    }
}

struct ChildView: View {
    @Binding var isBlue: Bool
    
    var body: some View {
        Toggle("Use Blue", isOn: $isBlue)
    }
}

#Preview {
    ParentView()
}
