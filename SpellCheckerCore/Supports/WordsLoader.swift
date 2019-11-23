import Foundation

public struct WordsLoader {
    public static func load(from url: URL) throws -> [String: Bool] {
        let string = try String(contentsOf: url)
        return dictionary(from: string)
    }

    static func dictionary(from string: String) -> [String: Bool] {
        let lines = string.split(separator: "\n")
        return lines.reduce(into: [:]) { (result, line) in
            guard !line.isEmpty else { return }
            let key = line.remove(without: .alphanumerics).lowercased()
            result[key] = true
        }
    }
}
