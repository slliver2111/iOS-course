//
//  ContentView.swift
//  Task 3
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

struct ParentView: View {
    @State var isBlue = true
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isBlue ? .blue : .red)
                .frame(width: 100, height: 150)
            ChildView(isBlue: $isBlue)
        }
    }
}

struct ChildView: View {
    @Binding var isBlue: Bool
    
    var body: some View {
        Toggle("Red/blue", isOn: $isBlue)
    }
}

#Preview {
    ParentView()
}
