//
//  String+extension.swift
//  TypoChecker
//
//  Created by Kazuya Ueoka on 2019/11/23.
//

import Foundation

extension String {
    func remove(without characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet.inverted).joined(separator: "")
    }
}

extension String.SubSequence {
    func remove(without characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet.inverted).joined(separator: "")
    }
}
