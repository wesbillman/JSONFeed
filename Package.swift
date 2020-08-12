// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSONFeed",
    platforms: [ .macOS(.v10_15), .iOS(.v13) ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "JSONFeed",
            targets: ["JSONFeed"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "JSONFeed",
            dependencies: [],
            exclude: ["JSONFeed.xcodeproj", "JSONFeedTests", ".travis.yml", "codecov.yml", ".swiftlint.yml"]
        ),
        .testTarget(
            name: "JSONFeedTests",
            dependencies: ["JSONFeed"],
            exclude: ["JSONFeed.xcodeproj", "JSONFeedTests", ".travis.yml", "codecov.yml", ".swiftlint.yml"],
            resources: [.copy("Feeds/simple.json"), .copy("Feeds/timetable.json")]
        )
    ]
)
