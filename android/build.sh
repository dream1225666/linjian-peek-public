#!/bin/bash
set -e

export JAVA_HOME=${JAVA_HOME:-/usr/lib/jvm/java-17-openjdk-amd64}
export ANDROID_HOME=${ANDROID_HOME:-$HOME/android-sdk}
PLATFORM=$ANDROID_HOME/platforms/android-34/android.jar
BUILD_TOOLS=$ANDROID_HOME/build-tools/34.0.0

PROJECT="$(cd "$(dirname "$0")" && pwd)"
SRC=$PROJECT/app/src/main
OUT=$PROJECT/build
PKG_PATH=dev/linjian/peek

if [ ! -f "$PLATFORM" ]; then
  echo "Android platform not found: $PLATFORM"
  echo "Install Android SDK platform 34 first."
  exit 1
fi

rm -rf "$OUT"
mkdir -p "$OUT/gen" "$OUT/classes" "$OUT/apk" "$OUT/compiled_res"

echo "=== Compiling resources ==="
$BUILD_TOOLS/aapt2 compile --dir "$SRC/res" -o "$OUT/compiled_res/"

echo "=== Linking resources ==="
$BUILD_TOOLS/aapt2 link \
    -o "$OUT/apk/app.unsigned.apk" \
    -I "$PLATFORM" \
    --manifest "$SRC/AndroidManifest.xml" \
    --java "$OUT/gen" \
    --auto-add-overlay \
    -R "$OUT/compiled_res"/*.flat

echo "=== Compiling Java ==="
find "$SRC/java" -name "*.java" > "$OUT/sources.txt"
回声"$OUT/gen/$PKG_PATH/R.java">>"$OUT/sources.txt""$OUT/gen/$PKG_PATH/R.java">>"$OUT/sources.txt"
javac-编码UTF-8-源11-目标11-类路径"$平台"-d"$OUT/classes"@"$OUT/sources.txt"-编码UTF-8-源 11 -目标 11 -classpath "$平台" -d "$OUT/classes" @"$OUT/sources.txt"

回声"===正在创建Dex===""===创建DEX==="
$BUILD_TOOLS/d8--输出"$OUT/apk/"--lib"$平台"$(查找"$OUT/classes"-name"*.class")/d8--输出 "$OUT/apk/" --lib "$平台"$(find"$OUT/classes" -name "*.class")

回声"===楼APK===""===正在构建APK==="
CD"$OUT/apk""$OUT/apk"
CP app.unsigned.apk app.tmp.apk
拉链-dapp.tmp.apk类.dex2>/dev/null||True-D app.tmp.apk classes.dex2>/dev/null||正确
拉链-j app.tmp.apk classes.dex-j app.tmp.apk classes.dex
MV app.tmp.apk app.unsigned.apk

回声"===加载固定的公共签名密钥==""===加载固定的公共签名密钥==="
public_KS=$PROJECT/签署/张新创-公开发布.p12=$PROJECT/signing/zhangxinchuang-public-release.p12
public_KS_PASSWORD=${PUBLIC_KS_PASSWORD：-张新创-public-30600}=${PUBLIC_KS_PASSWORD：-张新创-public-30600}
如果[！-f"$PUBLIC_KS"]；则 [ !-f "$PUBLIC_KS" ]; 然后
回声"未找到公共释放密钥库：$PUBLIC_KS""未找到公共发布密钥库：$PUBLIC_KS"
出口1出口1
Fi

回声"====对齐==""====对齐==="
$BUILD_TOOLS/zipalign-f4app.unsigned.apkapp.aligned.apk/zipalign -f 4app.unsigned.apk app.aligned.apk

回声"===签署公共安装包===""===签署公共安装包==="
$BUILD_TOOLS/apskigner符号\/apskigner符号\
--ks"$PUBLIC_KS"\--ks "$PUBLIC_KS" \
    --ks-typePKCS12\--ks-typePKCS12\
--ks-pass通过："$PUBLIC_KS_PASSWORD"\--ks-pass通过："$PUBLIC_KS_PASSWORD" \
--键-pass通过："$PUBLIC_KS_PASSWORD"\--键-pass通过："$PUBLIC_KS_PASSWORD" \
--ks-键-aliaszhangxinchuang-public\--ks-键-aliaszhangxinchuang-public\
--out"$PROJECT/Zhangxinchuang-public-v0.3.8.8.apk"\--out "$PROJECT/Zhangxinchuang-public-v0.3.8.8.apk" \
app.aligned.apk

回声"===验证固定公共签名===""===验证固定公共签名==="
verify_OUTPUT=$($BUILD_TOOLS/apksignerverify-verbose-print-certs"$PROJECT/Zhangxinchuang-public-v0.3.8.8.APK")=$($BUILD_TOOLS/apksigner验证-verbose-print-certs"$PROJECT/Zhangxinchuang-public-v0.3.8.8.apk")
回声"$VERIFY_OUTPUT""$VERIFY_OUTPUT"
回声"$VERIFY_OUTPUT"|grep-qi"aea75c9b2b5f5c42d56b72d4a69a79a38e1c57f27db021017be8656bc8f002fb""$VERIFY_OUTPUT"|grep-Qi "aea75c9b2b5f5c42d56b72d4a69a79a38e1c57f27db021017be8656bc8f002fb"

回显“”""
回声"===完成===""===完成==="
回声"APK：$PROJECT/Zhangxinchuang-public-v0.3.8.8.apk""安装包：$PROJECT/Zhangxinchuang-public-v0.3.8.8.apk"
ls -lh "$PROJECT/Zhangxinchuang-public-v0.3.8.8.apk"
