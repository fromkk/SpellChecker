// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpellChecker",
    products: [
        .executable(name: "SpellChecker", targets: ["SpellChecker"])
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.2")
    ],
    targets: [
        .target(
            name: "SpellChecker",
            dependencies: ["SpellCheckerCore", "Yams"]),
        .target(
            name: "SpellCheckerCore",
            dependencies: []),
        .testTarget(
            name: "SpellCheckerCoreTests",
            dependencies: ["SpellCheckerCore"]),
    ]
)
