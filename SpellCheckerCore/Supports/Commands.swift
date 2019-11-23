import Foundation

public struct Commands {
    static var arguments: [String] = CommandLine.arguments
    static var prefix: String = "-"
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
}
