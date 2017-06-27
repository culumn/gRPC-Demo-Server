// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "grpc-server",
    dependencies: [
        .Package(url: "https://github.com/grpc/grpc-swift.git", majorVersion: 0),
        .Package(url: "https://github.com/apple/swift-protobuf.git", majorVersion: 0),
    ]
)
