//
//  WordsLoaderTests.swift
//  SpellCheckerCoreTests
//
//  Created by Kazuya Ueoka on 2019/11/23.
//  Copyright © 2019 Kazuya Ueoka. All rights reserved.
//

import XCTest
@testable import SpellCheckerCore

final class WordsLoaderTests: XCTestCase {
    func testDictinoary() {
        let string = "ab.c\ndefg-hijk\nLmn"
        XCTAssertEqual(["abc": true, "defghijk": true, "lmn": true], WordsLoader.dictionary(from: string))
    }
}
