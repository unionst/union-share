// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "union-share",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "UnionShare",
            targets: ["UnionShare"]),
    ],
    targets: [
        .target(name: "UnionShare"),
    ]
)
