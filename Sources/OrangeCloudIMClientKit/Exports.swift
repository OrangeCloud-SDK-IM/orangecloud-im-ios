// 把二进制核心模块再导出，使客户 `import OrangeCloudIMClient` 即可使用全部 API，
// 同时本 target 通过依赖 SignalRClient 保证底层依赖在链接期可用。
@_exported import OrangeCloudIMClient
