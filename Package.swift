// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWHashTagViewController",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWHashTagViewController", targets: ["WWHashTagViewController"]),
    ],
    targets: [
        .target(name: "WWHashTagViewController", resources: [.process("Storyboard"), .copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
