import Foundation

struct FileLoader {
    let url: URL
    func load() throws -> String {
        return try String(contentsOf: url)
    }
}

struct LineParser {
    let string: String
    let url: URL
    func parse() -> [WordEntity] {
        var result: [WordEntity] = []
        let lines = string.split(separator: "\n", omittingEmptySubsequences: false)
        lines.enumerated().forEach { offset, line in
            let wordFinder = WordFinder(string: String(line), url: url, line: offset)
            result.append(contentsOf: wordFinder.find())
        }
        return result
    }
}

struct WordFinder {
    let string: String
    let url: URL
    let line: Int
    func find() -> [WordEntity] {
        var result: [WordEntity] = []
        var loop: Int = 0
        var word = ""
        var lastChar: Substring?

        func add(_ appendWord: String, position: Int) {
            if !appendWord.isEmpty {
                result.append(.init(url: url, line: line, position: position, value: appendWord.lowercased()))
            }
            word = ""
        }

        while loop < string.count {
            let from = string.index(string.startIndex, offsetBy: loop)
            let to = string.index(string.startIndex, offsetBy: loop + 1)
            let char = string[from..<to]
            let position = loop - word.count
            defer {
                loop += 1
                lastChar = char
            }

            if char.hasUpperCase() {
                // upper cases
                if word.isEmpty {
                    word.append(contentsOf: char)
                } else {
                    add(word, position: position)
                    word.append(contentsOf: char)
                }
            } else if char.hasLowerCase() {
                // lower cases
                word.append(contentsOf: char)
            } else if !word.isEmpty {
                add(word, position: position)
            }

            if loop == string.count - 1, !word.isEmpty {
                add(word, position: position)
            }
        }
        return result
    }
}

public struct WordParser {
    public let url: URL
    public init(url: URL) {
        self.url = url
    }

    public func parse() throws -> [WordEntity] {
        let loader = FileLoader(url: url)
        let string = try loader.load()
        let parser = LineParser(string: string, url: url)
        return parser.parse()
    }
}
