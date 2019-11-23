import SpellCheckerCore
import Foundation
import Yams

final class Main {
    enum SpellCheckerError: Error {
        case txtURLGetFailed
        case filesNotFound
    }

    private var txtURL: URL? {
        return Bundle.main.url(forAuxiliaryExecutable: "words.txt")
    }

    func run() throws {
        if Commands.has("h") || Commands.has("help") {
            help()
            return
        }

        guard let txtURL = txtURL else {
            throw SpellCheckerError.txtURLGetFailed
        }

        let files = Commands.array()
        guard !files.isEmpty else {
            throw SpellCheckerError.filesNotFound
        }

        var dictionary = try WordsLoader.load(from: txtURL)
        if let ymlPath = Commands.value(of: "yml") {
            let url = URL(fileURLWithPath: ymlPath)
            let entity = try options(for: url)
            if let whiteList = entity.whiteList, !whiteList.isEmpty {
                dictionary.merge(whiteList.reduce(into: [:], { $0[$1] = true }), uniquingKeysWith: { $1 })
            }
        }

        var warnings: [WordParser.Word] = []
        files.forEach { file in
            let url = URL(fileURLWithPath: file)
            let wordParser = WordParser(url: url)
            do {
                let words = try wordParser.parse()
                words.forEach { word in
                    if !(dictionary[word.value] ?? false) {
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
            print("\(word.url.path):\(word.line + 1):\(word.position + 1): warning: Is `\(word.value)` typo?")
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
