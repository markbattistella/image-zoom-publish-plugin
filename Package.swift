// swift-tools-version: 6.0
//
//  markbattistella.com
//  Created by Mark Battistella
//

import PackageDescription
import Foundation

let localPublishPath = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent("Sites/_publish-packages/Publish@0.8.0/Package.swift")
    .path

let publishDependency: Package.Dependency = FileManager.default.fileExists(atPath: localPublishPath)
    ? .package(name: "Publish", path: "../../Publish@0.8.0")
    : .package(url: "https://github.com/johnsundell/publish.git", from: "0.8.0")

let package = Package(
    name: "ImageZoom",
    products: [
        .library(
            name: "ImageZoom",
            targets: ["ImageZoom"]
        )
    ],
    dependencies: [
        publishDependency
    ],
    targets: [
        .target(
            name: "ImageZoom",
            dependencies: ["Publish"],
            exclude: ["Support/Utilities/zoom-image.js"]
        )
    ]
)
