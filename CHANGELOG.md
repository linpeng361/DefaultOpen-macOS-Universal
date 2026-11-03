# Changelog

## v1.0.9-universal

Initial Universal release based on DefaultOpen-macOS v1.0.9.

### Added
- **x86_64 (Intel) architecture support** — original project only shipped arm64
- **Universal binary** — single `.app` runs natively on both Intel and Apple Silicon
- Command-line build script (`build-universal.sh`) — no full Xcode required, only Command Line Tools
- Standalone GitHub project packaging

### Based on
- [DefaultOpen-macOS v1.0.9](https://github.com/lalalaladam/DefaultOpen-macOS) (GUI, SwiftUI)
- [duti](https://github.com/moretension/duti) (Launch Services C API engine)

### Changed
- Fixed `ApplicationCapabilityIndex.swift` `.sorted` closure type annotation for command-line `swiftc` compatibility
- Bundle display name retained as "DefaultOpen"

### Known Limitations
- ad-hoc signed (no Developer ID / notarization) — Gatekeeper prompt on first launch
- Some apps only declare abstract UTTypes with no file extension to remap
- Requires macOS 14.0+
