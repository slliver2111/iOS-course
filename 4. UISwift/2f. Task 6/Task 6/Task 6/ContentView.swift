//
//  ContentView.swift
//  Task 6
//
//  Created by Artur Bednarz on 07/08/2025.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    var inBasket: Bool
}

struct ContentView: View {
    @State private var listOfProducts = [
        Product(name: "Apple", inBasket: false),
        Product(name: "Pear", inBasket: false),
        Product(name: "Banana", inBasket: false),
        Product(name: "Egg", inBasket: true),
        Product(name: "Tuna", inBasket: false),
    ]
    
    var body: some View {
        NavigationStack {
            List($listOfProducts) { $product in
                Toggle(product.name, isOn: $product.inBasket)
                
            }
            .navigationTitle("Grocery List")
        }
    }
}

#Preview {
    ContentView()
}
