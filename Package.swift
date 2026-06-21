// swift-tools-version: 5.9
//
// OrangeCloud IM iOS SDK —— 二进制分发（XCFramework，按月付费授权使用，核心闭源）。
//
// 客户通过 SPM 引入本仓库即可，无需源码：
//   .package(url: "https://github.com/OrangeCloud-SDK-IM/orangecloud-im-ios.git", from: "2.0.0")
//
// 说明：
// - OrangeCloudIMClient 为二进制 XCFramework（真机 + 模拟器），核心逻辑闭源。
// - 底层依赖 SwiftSignalRClient 不打进二进制，由本 Package 声明并通过 wrapper target 传递链接，
//   客户无需手动再引（与腾讯云 IM iOS SDK 的分发方式一致）。

import PackageDescription

let package = Package(
    name: "OrangeCloudIMClient",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "OrangeCloudIMClient",
            targets: ["OrangeCloudIMClientKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/moozzyk/SignalR-Client-Swift", from: "0.9.0")
    ],
    targets: [
        // 二进制核心（闭源 XCFramework，内部 module 名为 OrangeCloudIMClient）
        .binaryTarget(
            name: "OrangeCloudIMClientBinary",
            path: "OrangeCloudIMClient.xcframework"
        ),
        // wrapper：把二进制核心与外部依赖 SignalRClient 绑定后统一对外暴露，
        // 使客户 import OrangeCloudIMClient 时自动链接 SignalRClient。
        .target(
            name: "OrangeCloudIMClientKit",
            dependencies: [
                "OrangeCloudIMClientBinary",
                .product(name: "SignalRClient", package: "SignalR-Client-Swift")
            ],
            path: "Sources/OrangeCloudIMClientKit"
        )
    ]
)
