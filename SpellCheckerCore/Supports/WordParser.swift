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
    func parse() -> [WordParser.Word] {
        var result: [WordParser.Word] = []
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
    func find() -> [WordParser.Word] {
        var result: [WordParser.Word] = []
        var loop: Int = 0
        var word = ""
        let characterSet = CharacterSet.alphanumerics
        var lastChar: Substring?

        func add(_ word: String, position: Int) {
            result.append(.init(url: url, line: line, position: position, value: word.lowercased()))
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

            if char.rangeOfCharacter(from: characterSet) == nil {
                // 半角英数字以外
                if !word.isEmpty {
                    add(word, position: position)
                    word = ""
                }
            } else {
                if char.hasNumber() {
                    // nothing todo
                } else if char.hasUpperCase() {
                    // 大文字
                    if word.isEmpty {
                        word.append(contentsOf: char)
                    } else {
                        add(word, position: position)
                        word = ""
                        word.append(contentsOf: char)
                    }
                } else if char.hasLowerCase() {
                    // 小文字
                    word.append(contentsOf: char)
                }
            }

            if loop == string.count - 1, !word.isEmpty {
                add(word, position: position)
            }
        }
        return result
    }
}

public struct WordParser {
    public struct Word: Equatable {
        public let url: URL
        public let line: Int
        public let position: Int
        public let value: String
    }

    public let url: URL
    public init(url: URL) {
        self.url = url
    }

    public func parse() throws -> [Word] {
        let loader = FileLoader(url: url)
        let string = try loader.load()
        let parser = LineParser(string: string, url: url)
        return parser.parse()
    }
}
