import Foundation

public struct WordEntity: Equatable {
    public let url: URL
    public let line: Int
    public let position: Int
    public let value: String
    public var suggestion: String?
}
