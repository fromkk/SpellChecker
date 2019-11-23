//
//  WordParser.swift
//  SpellCheckerCore
//
//  Created by Kazuya Ueoka on 2019/11/23.
//  Copyright © 2019 Kazuya Ueoka. All rights reserved.
//

import Foundation

public struct WordParser {
    public struct Word {
        public let url: URL
        public let line: Int
        public let position: Int
        public let word: String
    }
    
    private let url: URL
    public init(url: URL) {
        self.url = url
    }

    public func parse() throws -> [Word] {
        var result: [Word] = []
        // TODO: imprements
        return result
    }
}
