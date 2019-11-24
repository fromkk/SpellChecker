import XCTest
@testable import SpellCheckerCore

final class WordFinderTests: XCTestCase {
    func testEmpty() {
        let wordFinder = WordFinder(string: "", url: URL(string: "https://example.com/")!, line: 10)
        XCTAssertEqual(wordFinder.find(), [])
    }

    func testSpace() {
        let wordFinder = WordFinder(string: " ", url: URL(string: "https://example.com/")!, line: 10)
        XCTAssertEqual(wordFinder.find(), [])
    }

    func testAlnum() {
        let wordFinder = WordFinder(string: "abc", url: URL(string: "https://example.com/")!, line: 10)
        XCTAssertEqual(wordFinder.find(), [
            WordEntity(url: URL(string: "https://example.com/")!, line: 10, position: 0, value: "abc")
        ])
    }

    func testSnakeCase() {
        let wordFinder = WordFinder(string: " abc_def ", url: URL(string: "https://example.com/")!, line: 10)
        XCTAssertEqual(wordFinder.find(), [
            WordEntity(url: URL(string: "https://example.com/")!, line: 10, position: 1, value: "abc"),
            WordEntity(url: URL(string: "https://example.com/")!, line: 10, position: 5, value: "def")
        ])
    }

    func testCamelCase() {
        let wordFinder = WordFinder(string: " abcDefGhi ", url: URL(string: "https://example.com/")!, line: 10)
        XCTAssertEqual(wordFinder.find(), [
            WordEntity(url: URL(string: "https://example.com/")!, line: 10, position: 1, value: "abc"),
            WordEntity(url: URL(string: "https://example.com/")!, line: 10, position: 4, value: "def"),
            WordEntity(url: URL(string: "https://example.com/")!, line: 10, position: 7, value: "ghi")
        ])
    }

    func testNumber() {
        let wordFinder = WordFinder(string: " abc1DefGhi ", url: URL(string: "https://example.com/")!, line: 10)
        XCTAssertEqual(wordFinder.find(), [
            WordEntity(url: URL(string: "https://example.com/")!, line: 10, position: 1, value: "abc"),
            WordEntity(url: URL(string: "https://example.com/")!, line: 10, position: 5, value: "def"),
            WordEntity(url: URL(string: "https://example.com/")!, line: 10, position: 8, value: "ghi")
        ])
    }

    static var allTests = [
        ("testEmpty", testEmpty),
        ("testSpace", testSpace),
        ("testAlnum", testAlnum),
        ("testSnakeCase", testSnakeCase),
        ("testCamelCase", testCamelCase),
        ("testNumber", testNumber)
    ]
}
