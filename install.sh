#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

VERSION=${1:-"latest"}

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case $OS in
  linux) OS="linux" ;;
  darwin) OS="darwin" ;;
  *) echo -e "${RED}Unsupported OS: $OS${NC}"; exit 1 ;;
esac

case $ARCH in
  x86_64) ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *) echo -e "${RED}Unsupported architecture: $ARCH${NC}"; exit 1 ;;
esac

BINARY_NAME="tunneld-$OS-$ARCH"

if [ "$VERSION" = "latest" ]; then
  BINARY_URL="https://github.com/SubCodeAfrica/Tunneld/releases/latest/download/$BINARY_NAME"
  echo -e "${YELLOW}Installing latest version of TunnelAfrica Client (tunneld) for $OS/$ARCH...${NC}"
else
  BINARY_URL="https://github.com/SubCodeAfrica/Tunneld/releases/download/$VERSION/$BINARY_NAME"
  echo -e "${YELLOW}Installing TunnelAfrica Client (tunneld) $VERSION for $OS/$ARCH...${NC}"
fi

INSTALL_DIR="/usr/local/bin"

TMP_FILE=$(mktemp)

echo -e "${YELLOW}Downloading from $BINARY_URL...${NC}"
if command -v curl >/dev/null 2>&1; then
  if ! curl -L -f -o "$TMP_FILE" "$BINARY_URL"; then
    echo -e "${RED}Failed to download binary. Please check if the version exists.${NC}"
    exit 1
  fi
elif command -v wget >/dev/null 2>&1; then
  if ! wget -O "$TMP_FILE" "$BINARY_URL"; then
    echo -e "${RED}Failed to download binary. Please check if the version exists.${NC}"
    exit 1
  fi
else
  echo -e "${RED}Error: curl or wget is required${NC}"
  exit 1
fi

chmod +x "$TMP_FILE"

if [ -w "$INSTALL_DIR" ]; then
  mv "$TMP_FILE" "$INSTALL_DIR/tunneld"
else
  echo -e "${YELLOW}Installing to $INSTALL_DIR (requires sudo)${NC}"
  sudo mv "$TMP_FILE" "$INSTALL_DIR/tunneld"
fi

echo -e "${GREEN}✅ tunneld installed successfully!${NC}"
echo -e "${GREEN}Run 'tunneld --help' to get started.${NC}"

if command -v tunneld >/dev/null 2>&1; then
  echo -e "${GREEN}Installed version:${NC}"
  tunneld version 2>/dev/null || echo "Version info not available"
fi
