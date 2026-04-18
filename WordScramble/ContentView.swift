//
//  ContentView.swift
//  WordScramble
//
//  Created by Edwin Cardenas on 4/17/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
            }

            Section("Section 2") {
                ForEach(0..<5) {
                    Text("Dynamic row #\($0 + 1)")
                }
            }

            Section("Section 3") {
                Text("Static row 3")
                Text("Static row 4")
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    ContentView()
}
