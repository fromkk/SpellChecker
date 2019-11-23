//
//  CommandsTests.swift
//  SpellCheckerTests
//
//  Created by Kazuya Ueoka on 2019/11/23.
//  Copyright © 2019 Kazuya Ueoka. All rights reserved.
//

import XCTest
@testable import SpellCheckerCore

final class CommandsTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Commands.arguments = ["Commands", "-a", "hello"]
    }
    
    func testHasOption() {
        XCTAssertTrue(Commands.has("a"))
    }
    
    func testValue() {
        XCTAssertEqual(Commands.value(of: "a"), "hello")
        XCTAssertNil(Commands.value(of: "b"))
    }
}
