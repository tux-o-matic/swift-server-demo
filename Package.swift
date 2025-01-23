// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "EventService",
  platforms: [.macOS(.v14)],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-openapi-generator",
      from: "1.2.1"
    ),
    .package(
      url: "https://github.com/apple/swift-openapi-runtime",
      from: "1.4.0"
    ),
    .package(
      url: "https://github.com/vapor/vapor",
      from: "4.99.2"
    ),
    .package(
      url: "https://github.com/swift-server/swift-openapi-vapor",
      from: "1.0.1"
    ),
    .package(
      url: "https://github.com/vapor/postgres-nio",
      from: "1.19.1"
    ),
    .package(
        url: "https://github.com/apple/swift-log",
        from: "1.5.4"
    ),
  ],
  targets: [
    .target(
      name: "EventAPI",
      dependencies: [
        .product(
          name: "OpenAPIRuntime",
          package: "swift-openapi-runtime"
        ),
      ],
      plugins: [
        .plugin(
          name: "OpenAPIGenerator",
          package: "swift-openapi-generator"
        )
      ]
    ),
    .executableTarget(
      name: "EventService",
      dependencies: [
        "EventAPI",
        .product(
          name: "OpenAPIRuntime",
          package: "swift-openapi-runtime"
        ),
        .product(
          name: "OpenAPIVapor",
          package: "swift-openapi-vapor"
        ),
        .product(
          name: "Vapor",
          package: "vapor"
        ),
        .product(
            name: "PostgresNIO",
          package: "postgres-nio"
        ),
        .product(
            name: "Logging",
            package: "swift-log"
        ),
      ]
    ),
  ]
)
