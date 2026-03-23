#!/bin/bash

# Change to the script's directory
cd "$(dirname "$0")"

# Define paths (Linux-style)
BUILD_DIR="build/mewgenics_manager"
DIST_ROOT="dist"
APP_EXE_OUT="$DIST_ROOT/MewgenicsManager"

echo "Installing / updating dependencies..."
pip install -r requirements.txt
pip install pyinstaller

echo ""
echo "Cleaning previous build output..."
if [ -f "$APP_EXE_OUT" ]; then
    rm -f "$APP_EXE_OUT"
fi
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi

echo ""
echo "Building standalone executable..."
pyinstaller src/mewgenics_manager.spec --noconfirm --distpath "$DIST_ROOT"

echo ""
if [ -f "$APP_EXE_OUT" ]; then
    echo "Build succeeded!"
    echo "Executable: $APP_EXE_OUT"
    echo ""
    echo "Zipping executable..."
    cd "$DIST_ROOT"
    zip -r MewgenicsManager.zip MewgenicsManager
    cd ..
    if [ -f "$DIST_ROOT/MewgenicsManager.zip" ]; then
        echo "Zip created: $DIST_ROOT/MewgenicsManager.zip"
    else
        echo "Warning: zip creation failed."
    fi
else
    echo "Build FAILED - check output above."
fi
