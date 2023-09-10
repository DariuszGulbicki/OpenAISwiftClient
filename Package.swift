// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "OpenAISwiftClient",
    products: [
        .library(
            name: "ChatGPT",
            targets: ["ChatGPT"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DariuszGulbicki/Logging-Camp.git", from: "1.0.0"),
        .package(url: "https://github.com/DariuszGulbicki/SWAPI", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ChatGPT",
            dependencies: [
                .product(name: "LoggingCamp", package: "Logging-Camp"),
                .product(name: "SWAPI", package: "SWAPI"),
            ]),
        .testTarget(
            name: "OpenAISwiftClientTests",
            dependencies: ["ChatGPT"]),
    ]
)
