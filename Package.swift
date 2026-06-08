// swift-tools-version:6.2

import PackageDescription

extension String {
    static let iso639: Self = "ISO 639"
}

extension String { var tests: Self { self + " Tests" } }

extension Target.Dependency {
    static var iso639: Self { .target(name: .iso639) }
    static var standards: Self { .product(name: "Standards", package: "swift-standards") }
    static var incits_4_1986: Self { .product(name: "INCITS 4 1986", package: "swift-incits-4-1986") }
    static var standardsTestSupport: Self { .product(name: "StandardsTestSupport", package: "swift-standards") }
}

let package = Package(
    name: "swift-iso-639",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(name: .iso639, targets: [.iso639]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-standards", from: "0.10.0"),
        .package(url: "https://github.com/swift-standards/swift-incits-4-1986", from: "0.6.3")
    ],
    targets: [
        .target(
            name: .iso639,
            dependencies: [
                .standards,
                .incits_4_1986
            ],
            resources: [
                .copy("Data")
            ]
        ),
        .testTarget(
            name: .iso639.tests,
            dependencies: [
                .iso639,
                .incits_4_1986,
                .standardsTestSupport
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
