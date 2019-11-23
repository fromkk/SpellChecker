import XCTest
@testable import SpellCheckerCore

final class WordsLoaderTests: XCTestCase {
    func testDictinoary() {
        let string = "ab.c\ndefg-hijk\nLmn"
        XCTAssertEqual(["abc": true, "defghijk": true, "lmn": true], WordsLoader.dictionary(from: string))
    }
}
