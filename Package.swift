// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NPKComputation",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NPKComputation",
            targets: ["NPKComputation"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // I added the DoodleMatrix files directly into this package
        //.package(url: "https://github.com/Donk970/DoodleMatrix.git", from: "0.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NPKComputation",
            dependencies: []),
        .testTarget(
            name: "NPKComputationTests",
            dependencies: ["NPKComputation"]),
    ]
)
