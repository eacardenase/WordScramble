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
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingAlert = false
    @State private var selection: TextSelection?

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField(
                        "Enter your word",
                        text: $newWord,
                        selection: $selection
                    )
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
            .alert(errorTitle, isPresented: $showingAlert) {
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button {
                    startGame()
                } label: {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
            }
        }
    }

    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !answer.isEmpty, answer.count >= 3, answer != rootWord else {
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")

            return
        }

        guard isPossible(word: answer) else {
            wordError(
                title: "Word not possible",
                message: "You can't spell that word from '\(rootWord)'"
            )

            return
        }

        guard isReal(word: answer) else {
            wordError(
                title: "Word not recognized",
                message: "You can't just make them up, you know!"
            )

            return
        }

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

    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let index = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: index)
            } else {
                return false
            }
        }

        return true
    }

    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )

        return misspelledRange.location == NSNotFound
    }

    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
