// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SwiftUI-PullToRefresh",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftUI-PullToRefresh",
            targets: ["SwiftUI-PullToRefresh"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/YuantongL/SwiftUI-PullToRefresh.git", from: "1.0")
    ],
    targets: [
        .target(
            name: "SwiftUI-PullToRefresh",
            dependencies: [],
            path: "Sources"
        )
    ]
)
