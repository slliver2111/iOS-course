//
//  SwiftUIView.swift
//  Task 1 Interoper
//
//  Created by Artur Bednarz on 16/08/2025.
//

import SwiftUI

struct SwiftUIView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Hello SwiftUI!")
            Button("Dissmis View") {
                dismiss()
            }
        }
        .toolbarVisibility(.hidden)
        
    }
}

#Preview {
    SwiftUIView()
}
