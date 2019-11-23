import Foundation

public struct Commands {
    static var arguments: [String] = CommandLine.arguments
    static var prefix: String = "-"
    static var arraySeparator: String = "--"
    public static func has(_ option: String) -> Bool {
        let rawValue = prefix + option
        return arguments.contains(rawValue)
    }

    public static func value(of option: String) -> String? {
        let rawValue = prefix + option
        guard let index = arguments.firstIndex(of: rawValue) else {
            return nil
        }
        let nextIndex = arguments.index(index, offsetBy: 1)
        return arguments.count > nextIndex ? arguments[nextIndex] : nil
    }

    public static func array() -> [String] {
        guard var index = arguments.firstIndex(of: arraySeparator) else {
            return []
        }
        index = arguments.index(index, offsetBy: 1)
        var result: [String] = []
        repeat {
            defer {
                index = arguments.index(index, offsetBy: 1)
            }
            let value = arguments[index]
            guard !value.isEmpty else { continue }
            result.append(value)
        } while arguments.count > index
        return result
    }
}
