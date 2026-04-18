//
//  ContentView.swift
//  WordScramble
//
//  Created by Edwin Cardenas on 4/17/26.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .keyboardType(.asciiCapable)
                        .textInputAutocapitalization(.never)
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle("hola")
            .onSubmit(addNewWord)
        }
    }

    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !answer.isEmpty else { return }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }

        newWord = ""
    }
}

#Preview {
    ContentView()
}
