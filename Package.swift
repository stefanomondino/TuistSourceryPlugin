// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let package = Package(
    name: "tuist-sourcery",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "tuist-sourcery", targets: ["SourceryPlugin"])],
    dependencies: [.package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
                   .package(url: "https://github.com/tuist/ProjectAutomation", .upToNextMajor(from: "3.14.0")),
                   .package(url: "https://github.com/kylef/PathKit.git", exact: "1.0.1")],
    targets: [.executableTarget(
        name: "SourceryPlugin",
        dependencies: [.product(name: "ProjectAutomation", package: "ProjectAutomation"),
                       .product(name: "ArgumentParser", package: "swift-argument-parser"),
                       .product(name: "PathKit", package: "PathKit")]
    )]
)
