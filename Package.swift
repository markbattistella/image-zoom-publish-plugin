// swift-tools-version: 6.0
//
//  markbattistella.com
//  Created by Mark Battistella
//

import PackageDescription

let package = Package(
    name: "ImageZoom",
    products: [
        .library(
            name: "ImageZoom",
            targets: ["ImageZoom"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/johnsundell/publish.git",
            .upToNextMinor(from: "0.8.0")
        )
    ],
    targets: [
        .target(
            name: "ImageZoom",
            dependencies: [
                .product(name: "Publish", package: "publish")
            ],
            exclude: ["Support/Utilities/zoom-image.js"]
        )
    ]
)
