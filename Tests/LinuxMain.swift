import XCTest

import SpellCheckerTests

var tests = [XCTestCaseEntry]()
tests += CommandsTests.allTests()
tests += WordFinderTests.allTests()
tests += WordsLoaderTests.allTests()
XCTMain(tests)
