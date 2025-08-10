// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "flutter_permission_handler_plus",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "flutter_permission_handler_plus",
            targets: ["flutter_permission_handler_plus"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/flutter/flutter.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "flutter_permission_handler_plus",
            dependencies: [
                .product(name: "Flutter", package: "flutter"),
            ],
            path: "Classes"
        ),
    ]
)
