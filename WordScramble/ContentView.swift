//
//  ContentView.swift
//  WordScramble
//
//  Created by Edwin Cardenas on 4/17/26.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        List {
            Text("Static row")

            ForEach(people, id: \.self) {
                Text($0)
            }

            Text("Static row")
        }
    }
}

#Preview {
    ContentView()
}
