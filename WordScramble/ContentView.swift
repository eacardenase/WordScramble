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
                        .autocorrectionDisabled()
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
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
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

    private func startGame() {
        guard
            let startingWordsUrl = Bundle.main.url(
                forResource: "start",
                withExtension: "txt"
            )
        else {
            fatalError("Could not load start.txt from bundle.")
        }

        if let startingWords = try? String(
            contentsOf: startingWordsUrl,
            encoding: .utf8
        ) {
            let allWords = startingWords.components(separatedBy: "\n")

            rootWord = allWords.randomElement() ?? "alarming"
        }
    }
}

#Preview {
    ContentView()
}
