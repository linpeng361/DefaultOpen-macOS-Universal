# v1.0.9-universal

基于 [DefaultOpen-macOS v1.0.9](https://github.com/lalalaladam/DefaultOpen-macOS) 构建的 **Universal 通用二进制**，同时支持 Intel Mac 和 Apple Silicon。

> 由 **豆包 AI + 本人** 共同构建。

## 下载

| 文件 | 大小 | 说明 |
|------|------|------|
| [DefaultOpen-v1.0.9-universal.zip](https://github.com/你的用户名/DefaultOpen-macOS-Universal/releases/download/v1.0.9-universal/DefaultOpen-v1.0.9-universal.zip) | 3.8 MB | Universal (x86_64 + arm64) |
| [DefaultOpen-v1.0.9-universal.sha256](https://github.com/你的用户名/DefaultOpen-macOS-Universal/releases/download/v1.0.9-universal/DefaultOpen-v1.0.9-universal.sha256) | — | 校验文件 |

## 系统要求

- macOS 14.0 (Sonoma) 或更高
- Intel Mac (x86_64) 或 Apple Silicon (arm64)

## 安装

1. 下载并解压 ZIP
2. 将 `DefaultOpen.app` 拖入「应用程序」
3. 首次打开：**Control + 点按** → 打开（绕过 Gatekeeper）

> ad-hoc 签名，无 Developer ID 公证，首次打开需手动确认。

## 校验

```bash
shasum -a 256 -c DefaultOpen-v1.0.9-universal.sha256
```

SHA-256: `9513a2d4d211509d30e75808fa059de0d2ed6b13517056ce0bdabacaf9879651`

## 功能

- 查看和修改文件扩展名 / UTType 的默认打开应用
- 管理 URL Scheme 默认处理器
- 批量修改浏览器、视频、音乐、图片、PDF、文本、办公文档默认应用
- 扫描已安装应用声明的文档类型
- 简体中文 / English 双语界面

## 致谢

- [DefaultOpen-macOS](https://github.com/lalalaladam/DefaultOpen-macOS) — 原始 GUI 项目
- [duti](https://github.com/moretension/duti) — Launch Services 命令行工具（底层 API 同源）

构建：**豆包 AI + 本人**
