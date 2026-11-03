#!/bin/bash
#
# build-universal.sh — 构建 DefaultOpen Universal 应用 (x86_64 + arm64)
#
# 前置要求: Xcode Command Line Tools (swiftc), Python 3
# 产物: ./DefaultOpen.app
#
set -euo pipefail
cd "$(dirname "$0")"

APP_NAME="DefaultOpen"
BUNDLE_ID="com.lalalaladam.DefaultOpen"
VERSION="1.0.9"
BUILD="1"
MIN_MACOS="14.0"

BUILD_DIR="./build"
APP_DIR="./${APP_NAME}.app"

SWIFT_FILES=$(find Sources -name "*.swift" | sort)
FRAMEWORKS="-framework AppKit -framework SwiftUI -framework CoreServices -framework UniformTypeIdentifiers -framework CoreSpotlight -framework Combine"

echo "==> 清理旧产物"
rm -rf "$BUILD_DIR" "$APP_DIR"
mkdir -p "$BUILD_DIR"

echo "==> 编译 x86_64 (Intel)"
swiftc -target "x86_64-apple-macos${MIN_MACOS}" -O $FRAMEWORKS \
  -o "${BUILD_DIR}/${APP_NAME}-x86_64" $SWIFT_FILES

echo "==> 编译 arm64 (Apple Silicon)"
swiftc -target "arm64-apple-macos${MIN_MACOS}" -O $FRAMEWORKS \
  -o "${BUILD_DIR}/${APP_NAME}-arm64" $SWIFT_FILES

echo "==> 合并 Universal 二进制"
lipo -create "${BUILD_DIR}/${APP_NAME}-x86_64" "${BUILD_DIR}/${APP_NAME}-arm64" \
  -o "${BUILD_DIR}/${APP_NAME}"

echo "==> 创建 .app 包"
mkdir -p "${APP_DIR}/Contents/MacOS"
mkdir -p "${APP_DIR}/Contents/Resources"
cp "${BUILD_DIR}/${APP_NAME}" "${APP_DIR}/Contents/MacOS/${APP_NAME}"
chmod +x "${APP_DIR}/Contents/MacOS/${APP_NAME}"

cat > "${APP_DIR}/Contents/Info.plist" << PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key><string>zh_CN</string>
    <key>CFBundleDisplayName</key><string>${APP_NAME}</string>
    <key>CFBundleExecutable</key><string>${APP_NAME}</string>
    <key>CFBundleIconFile</key><string>AppIcon</string>
    <key>CFBundleIdentifier</key><string>${BUNDLE_ID}</string>
    <key>CFBundleInfoDictionaryVersion</key><string>6.0</string>
    <key>CFBundleName</key><string>${APP_NAME}</string>
    <key>CFBundlePackageType</key><string>APPL</string>
    <key>CFBundleShortVersionString</key><string>${VERSION}</string>
    <key>CFBundleVersion</key><string>${BUILD}</string>
    <key>LSApplicationCategoryType</key><string>public.app-category.utilities</string>
    <key>LSMinimumSystemVersion</key><string>${MIN_MACOS}</string>
    <key>NSHighResolutionCapable</key><true/>
</dict>
</plist>
PLIST

echo "==> 处理图标"
ICONSET_DIR="/tmp/AppIcon.iconset"
rm -rf "$ICONSET_DIR" && mkdir -p "$ICONSET_DIR"
ICON_SRC="Sources/Assets.xcassets/AppIcon.appiconset"
if [ -d "$ICON_SRC" ]; then
  cp "$ICON_SRC/16.png"     "$ICONSET_DIR/icon_16x16.png" 2>/dev/null || true
  cp "$ICON_SRC/32.png"     "$ICONSET_DIR/icon_16x16@2x.png" 2>/dev/null || true
  cp "$ICON_SRC/32@1x.png"  "$ICONSET_DIR/icon_32x32.png" 2>/dev/null || true
  cp "$ICON_SRC/128.png"    "$ICONSET_DIR/icon_32x32@2x.png" 2>/dev/null || true
  cp "$ICON_SRC/128.png"    "$ICONSET_DIR/icon_128x128.png" 2>/dev/null || true
  cp "$ICON_SRC/256.png"    "$ICONSET_DIR/icon_128x128@2x.png" 2>/dev/null || true
  cp "$ICON_SRC/256.png"    "$ICONSET_DIR/icon_256x256.png" 2>/dev/null || true
  cp "$ICON_SRC/512.png"    "$ICONSET_DIR/icon_256x256@2x.png" 2>/dev/null || true
  cp "$ICON_SRC/512.png"    "$ICONSET_DIR/icon_512x512.png" 2>/dev/null || true
  cp "$ICON_SRC/1024.png"   "$ICONSET_DIR/icon_512x512@2x.png" 2>/dev/null || true
  iconutil -c icns "$ICONSET_DIR" -o "${APP_DIR}/Contents/Resources/AppIcon.icns"
fi

echo "==> 生成本地化"
python3 << 'PYEOF'
import json, os
xcstrings = 'Sources/Localizable.xcstrings'
resources = 'DefaultOpen.app/Contents/Resources'
if not os.path.exists(xcstrings):
    exit(0)
with open(xcstrings, 'r') as f:
    strings = json.load(f).get('strings', {})
def esc(s): return s.replace('\\','\\\\').replace('"','\\"').replace('\n','\\n')
for lang in ['zh-Hans', 'en']:
    lproj = os.path.join(resources, f'{lang}.lproj')
    os.makedirs(lproj, exist_ok=True)
    lines = []
    for key, val in strings.items():
        locs = val.get('localizations', {})
        v = locs[lang].get('stringUnit', {}).get('value', key) if lang in locs else (key if lang == 'en' else None)
        if v: lines.append(f'"{esc(key)}" = "{esc(v)}";')
    with open(os.path.join(lproj, 'Localizable.strings'), 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines) + '\n')
PYEOF

echo ""
echo "✅ 构建完成"
lipo -info "${APP_DIR}/Contents/MacOS/${APP_NAME}"
echo "大小: $(du -sh ${APP_DIR} | cut -f1)"
echo "运行: open ${APP_DIR}"
