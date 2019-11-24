import XCTest
@testable import SpellCheckerCore

final class CommandsTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Commands.arguments = ["Commands", "-a", "hello", "--", "a.txt", "b.txt"]
    }
    
    func testHasOption() {
        XCTAssertTrue(Commands.has("a"))
    }
    
    func testValue() {
        XCTAssertEqual(Commands.value(of: "a"), "hello")
        XCTAssertNil(Commands.value(of: "b"))
    }

    func testArray() {
        XCTAssertEqual(Commands.array(), ["a.txt", "b.txt"])
    }

    static var allTests = [
        ("testHasOption", testHasOption),
        ("testValue", testValue),
        ("testArray", testArray)
    ]
}
