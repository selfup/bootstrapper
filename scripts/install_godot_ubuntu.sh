#!/usr/bin/env bash
set -euo pipefail

# install_godot_ubuntu.sh — download, verify, and install Godot (standard build) on Ubuntu.
# Verifies the download against the official SHA512-SUMS.txt before installing.
# Installs entirely in user space — no sudo, no root-owned paths.

env_file='.bootstrapper.env'

if [[ -f $env_file ]]
then
    source $env_file
else
    echo 'not at root of repo.. ENV file is not found..'
    echo 'aborting'
    exit 1
fi

VERSION="${GODOT_VERSION}"
ZIP="Godot_v${VERSION}_linux.x86_64.zip"
BIN="Godot_v${VERSION}_linux.x86_64"
BASE="https://github.com/godotengine/godot/releases/download/${VERSION}"
URL="${BASE}/${ZIP}"
SUMS_URL="${BASE}/SHA512-SUMS.txt"
ICON_URL="https://godotengine.org/assets/press/icon_color.png"

INSTALL_PATH="${HOME}/.local/bin/godot"
ICON_PATH="${HOME}/.local/share/icons/godot.png"
DESKTOP_PATH="${HOME}/.local/share/applications/godot.desktop"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "==> Downloading Godot ${VERSION}..."
curl -fL "$URL" -o "${TMP}/${ZIP}"

echo "==> Downloading SHA512-SUMS.txt..."
curl -fL "$SUMS_URL" -o "${TMP}/SHA512-SUMS.txt"

echo "==> Verifying checksum..."
# SHA512-SUMS.txt lists every platform; isolate our file, then verify in $TMP.
grep " ${ZIP}\$" "${TMP}/SHA512-SUMS.txt" > "${TMP}/expected.sha512"
if [ ! -s "${TMP}/expected.sha512" ]; then
  echo "ERROR: no checksum entry found for ${ZIP}. Aborting." >&2
  exit 1
fi
( cd "$TMP" && sha512sum -c expected.sha512 )
echo "    Checksum OK."

echo "==> Extracting..."
unzip -q "${TMP}/${ZIP}" -d "$TMP"

echo "==> Installing binary to ${INSTALL_PATH}..."
mkdir -p "$(dirname "$INSTALL_PATH")"
mv "${TMP}/${BIN}" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo "==> Installing icon to ${ICON_PATH}..."
mkdir -p "$(dirname "$ICON_PATH")"
curl -fL "$ICON_URL" -o "$ICON_PATH"

echo "==> Creating desktop entry at ${DESKTOP_PATH}..."
mkdir -p "$(dirname "$DESKTOP_PATH")"
cat > "$DESKTOP_PATH" << EOF
[Desktop Entry]
Name=Godot Engine
Exec=${INSTALL_PATH}
Icon=${ICON_PATH}
Type=Application
Categories=Development;
Terminal=false
EOF

echo "==> Done."
if ! command -v godot >/dev/null 2>&1; then
  echo "    Note: ~/.local/bin isn't on your PATH in this shell yet."
  echo "    Run 'source ~/.profile' or open a new login shell, then 'godot'."
else
  echo "    Run 'godot' from a terminal, or launch it from your application menu."
fi
echo "    Godot 4.x defaults to the Vulkan (Forward+) renderer — if it black-screens"
echo "    or crashes on startup, check your NVIDIA/Vulkan drivers with 'vulkaninfo'."
