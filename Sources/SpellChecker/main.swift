import SpellCheckerCore
import Foundation
import Yams
import Cocoa

final class Main {
    enum SpellCheckerError: Error {
        case filesNotFound
        case unsupportedLanguage(String)
    }

    func run() throws {
        if Commands.has("h") || Commands.has("help") {
            help()
            return
        }

        let files = Commands.array()
        guard !files.isEmpty else {
            throw SpellCheckerError.filesNotFound
        }

        let spellChecker = NSSpellChecker.shared

        if let ymlPath = Commands.value(of: "yml") {
            let url = URL(fileURLWithPath: ymlPath)
            let entity = try options(for: url)
            if let whiteList = entity.whiteList, !whiteList.isEmpty {
                spellChecker.setIgnoredWords(whiteList, inSpellDocumentWithTag: 0)
            }
        }
        
        let language = Commands.value(of: "language") ?? "en"
        if !spellChecker.setLanguage(language) {
            throw SpellCheckerError.unsupportedLanguage(language)
        }

        var warnings: [WordEntity] = []
        files.forEach { file in
            let url = URL(fileURLWithPath: file)
            let wordParser = WordParser(url: url)
            do {
                let words = try wordParser.parse()
                words.forEach { word in
                    var word = word
                    let range = spellChecker.checkSpelling(of: word.value, startingAt: 0)
                    if range.location < word.value.count {
                        if let suggest = spellChecker.correction(forWordRange: range, in: word.value, language: language, inSpellDocumentWithTag: 0) {
                            word.suggestion = suggest
                        }
                        warnings.append(word)
                    }
                }
            } catch {
                print("parse failed for \(url) with error: \(error)")
                exit(1)
            }
        }

        guard warnings.count != 0 else {
            print("no typo!")
            return
        }

        warnings.forEach { word in
            if let suggestion = word.suggestion {
                print("\(word.url.path):\(word.line + 1):\(word.position + 1): warning: Maybe `\(word.value)` is typo of `\(suggestion)`. (SpellChecker)")
            } else {
                print("\(word.url.path):\(word.line + 1):\(word.position + 1): warning: Is `\(word.value)` typo? (SpellChecker)")
            }
        }
    }

    func help() {
        let help = """
Usage: SpellChecker [-yml <YAML file path>] -- <check file path list...>

Options:
  -yml: White list YAML file
  --  : Typo check list of file path
"""
        print(help)
    }

    func options(for url: URL) throws -> YmlEntity {
        let ymlString = try file(for: url)
        let decoder = YAMLDecoder()
        return try decoder.decode(from: ymlString)
    }

    func file(for url: URL) throws -> String {
        return try String(contentsOf: url)
    }
}

let main = Main()
do {
    try main.run()
    exit(0)
} catch {
    print("something wrong... \(error)")
    exit(1)
}
