# OrangeCloud IM SDK - iOS

[![Platform](https://img.shields.io/badge/platform-iOS%2013%2B-000000?logo=apple)](https://developer.apple.com)
[![SPM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen)](https://swift.org/package-manager)
[![Version](https://img.shields.io/badge/version-2.0.0-blue)](https://github.com/OrangeCloud-SDK-IM/orangecloud-im-ios/releases)

OrangeCloud IM iOS SDK，以 **XCFramework 二进制**分发（核心闭源，按月付费授权使用）。

## 安装（Swift Package Manager）

```swift
dependencies: [
    .package(url: "https://github.com/OrangeCloud-SDK-IM/orangecloud-im-ios.git", from: "2.0.0")
]
```

底层依赖 `SwiftSignalRClient` 由本包自动引入，无需手动添加。最低 iOS 13 / macOS 10.15。

## 快速开始

```swift
import OrangeCloudIMClient
import Combine

let client = OCIMClient()
var bag = Set<AnyCancellable>()

client.onTextMessage.sink { msg in
    print(msg.senderInfo.nickName, msg.content)
}.store(in: &bag)
client.onGiftMessage.sink { print("礼物", $0.giftName) }.store(in: &bag)
client.onConnectionStateChanged.sink { print("状态", $0) }.store(in: &bag)

// userSig 由接入方业务服务端签发
client.login(hubUrl: "wss://api.xxx.com/livehub", appId: "APPID", userId: "user_1", userSig: "USERSIG")
client.joinGroup("room1")
client.sendTextMessage(groupId: "room1", content: "大家好")
```

## 字段访问（与 Web / Android / Flutter 一致）

| 消息 | 访问方式 |
|---|---|
| 文本 | `msg.content` |
| 礼物 | `msg.giftId` / `msg.giftName` / `msg.giftCount` / `msg.giftPrice` / `msg.animationUrl` |
| 系统通知 | `msg.noticeType` / `msg.title` / `msg.content` |
| 自定义 | `msg.customType` / `msg.payload` |

## License

商业授权，按月付费。
