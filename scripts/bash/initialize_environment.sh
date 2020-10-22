#!/bin/bash

set -o pipefail

export BASH_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export SCRIPT_DIR="$(dirname "$BASH_SCRIPT_DIR")"
export PROJ_ROOT="$(dirname "$SCRIPT_DIR")"
export VENDOR_ROOT="$PROJ_ROOT/vendors"
export FIREBASE_ROOT="$VENDOR_ROOT/firebase"
export SERVER_ROOT="$FIREBASE_ROOT/functions"
export APP_ROOT="$PROJ_ROOT/projects/app"
export ANDROID_APP_ROOT="$APP_ROOT/android"
export SITE_ROOT="$PROJ_ROOT/site"

echo "Initialize build area for Firebase release."
export BUILD_DIR="$FIREBASE_ROOT/build"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "Extract Dart path from Flutter location."
export FLUTTER_PATH="$(which flutter)"
export FLUTTER_BIN="$(dirname "$FLUTTER_PATH")"
export FLUTTER_ROOT="$(dirname "$FLUTTER_BIN")"
export DART_BIN="$FLUTTER_BIN/cache/dart-sdk/bin/"
