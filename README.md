# DefaultOpen-macOS-Universal

轻量级 macOS 默认应用管理工具 — 原生支持 **Intel (x86_64)** 与 **Apple Silicon (arm64)** 双架构。

基于 [duti](https://github.com/moretension/duti) 的 Launch Services 底层能力与 [DefaultOpen-macOS](https://github.com/lalalaladam/DefaultOpen-macOS) 的 SwiftUI 图形界面构建。

> 本项目由 **豆包 AI + 本人** 共同构建完成。

## 截图

<!-- 待添加 -->

## 功能

- 查看文件扩展名、UTType 和当前默认打开应用
- 修改单个或批量文件类型的默认打开应用
- 扫描已安装应用声明的文档类型、UTType 和 URL Scheme
- 按应用名称、Bundle Identifier、扩展名或文件类型搜索
- 管理浏览器、视频、音乐、图片、PDF、文本和办公文档等默认应用组合
- 创建自定义扩展名和自定义默认应用组合
- 简体中文 / English 界面

## 系统要求

- **macOS 14.0 (Sonoma) 或更高版本**
- Intel Mac (x86_64) 或 Apple Silicon (arm64)

## 下载

前往 [Releases](https://github.com/你的用户名/DefaultOpen-macOS-Universal/releases) 下载最新版本：

| 文件 | 说明 |
|------|------|
| `DefaultOpen-v1.0.9-universal.zip` | Universal 通用二进制，同时支持 Intel 和 Apple Silicon |

### 校验

```bash
shasum -a 256 -c DefaultOpen-v1.0.9-universal.sha256
```

### 安装

1. 解压 ZIP 文件
2. 将 `DefaultOpen.app` 拖入「应用程序」文件夹
3. 首次打开：按住 **Control** 点按应用 → 选择「打开」
   （或前往「系统设置 → 隐私与安全性」点击「仍要打开」）

> 本应用使用 ad-hoc 签名，无 Apple Developer ID，未经 Apple 公证。

## 从源码构建

仅需 Xcode Command Line Tools（无需完整 Xcode）：

```bash
git clone https://github.com/你的用户名/DefaultOpen-macOS-Universal.git
cd DefaultOpen-macOS-Universal
./build-universal.sh
```

产物：`DefaultOpen.app`（Universal 二进制）

### 构建要求

- macOS 14.0+
- Xcode Command Line Tools（含 `swiftc`）
- Python 3（用于生成本地化资源）

## 技术说明

- **底层引擎**：与 duti 同源的公开 Launch Services C API
  - `LSCopyDefaultRoleHandlerForContentType`
  - `LSSetDefaultRoleHandlerForContentType`
  - `LSCopyDefaultHandlerForURLScheme`
  - `LSSetDefaultHandlerForURLScheme`
- **图形界面**：SwiftUI + AppKit
- **无依赖**：不依赖任何第三方命令行工具，无需管理员权限
- **未启用 App Sandbox**：以便扫描 `/Applications` 等目录

## 致谢

- [duti](https://github.com/moretension/duti) — Andrew Mortensen，公有领域
- [DefaultOpen-macOS](https://github.com/lalalaladam/DefaultOpen-macOS) — lalalaladam（原始 GUI 项目）

本项目在 DefaultOpen-macOS 基础上补充了 Intel (x86_64) 架构支持，并提供命令行构建脚本。

构建：**豆包 AI + 本人**

## 许可证

MIT License
