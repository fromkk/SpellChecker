//
//  WordEntity.swift
//  SpellCheckerCore
//
//  Created by Kazuya Ueoka on 2019/11/24.
//  Copyright © 2019 Kazuya Ueoka. All rights reserved.
//

import Foundation

public struct WordEntity: Equatable {
    public let url: URL
    public let line: Int
    public let position: Int
    public let value: String
    public var suggestion: String?
}
