//
//  ContentView.swift
//  Task 5
//
//  Created by Artur Bednarz on 07/08/2025.
//
 
import SwiftUI

struct CardView<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.title)
            content()
        }
        .padding(16)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40) {
            CardView(title: "Card 1") {
                HStack {
                    Button("Ok") {}
                    Button("Cancel") {}
                }
            }
            CardView(title: "Card 2") {
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color.red)
                    Image(systemName: "square.fill")
                        .foregroundColor(Color.green)
                    Image(systemName: "triangle.fill")
                        .foregroundColor(Color.yellow)
                }
            }
            CardView(title: "Card 3") {
                Text("Some example text")
            }
        }
    }
}

#Preview {
    ContentView()
}
