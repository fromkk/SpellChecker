import Foundation

extension Substring {
    func hasNumber() -> Bool {
        let characterSet = CharacterSet.decimalDigits
        return rangeOfCharacter(from: characterSet) != nil
    }

    func hasLowerCase() -> Bool {
        let characterSet = CharacterSet.lowercaseLetters
        return rangeOfCharacter(from: characterSet) != nil
    }

    func hasUpperCase() -> Bool {
        let characterSet = CharacterSet.uppercaseLetters
        return rangeOfCharacter(from: characterSet) != nil
    }
}
