import SpellCheckerCore
import Foundation
import Yams

final class Main {
    private var txtURL: URL? {
        return Bundle.main.url(forAuxiliaryExecutable: "words.txt")
    }
    
    func run() throws {
        guard let txtURL = txtURL else {
            print("txtURL get failed")
            exit(1)
        }
        
        var dictionary = try WordsLoader.load(from: txtURL)
        if let ymlPath = Commands.value(of: "yml") {
            let url = URL(fileURLWithPath: ymlPath)
            let entity = try options(for: url)
            if let whiteList = entity.whiteList, !whiteList.isEmpty {
                dictionary.merge(whiteList.reduce(into: [:], { $0[$1] = true }), uniquingKeysWith: { $1 })
            }
        }
        print(dictionary)
    }

    func options(for url: URL) throws -> YmlEntity {
        let ymlString = try String(contentsOf: url)
        let decoder = YAMLDecoder()
        return try decoder.decode(from: ymlString)
    }
}

let main = Main()
do {
    try main.run()
} catch {
    print("something wrong... \(error)")
    exit(1)
}
