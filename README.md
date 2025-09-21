# TunnelAfrica Client (tunneld)

The official command-line client for TunnelAfrica tunneling service.

## Quick Install

### Linux & macOS
```bash
curl -sSL https://raw.githubusercontent.com/SubCodeAfrica/Tunneld/main/install.sh | bash
```

**Install specific version:**
```bash
curl -sSL https://raw.githubusercontent.com/SubCodeAfrica/Tunneld/main/install.sh | bash -s v1.0.0
```

### Windows (PowerShell as Administrator)
```powershell
iwr -useb https://raw.githubusercontent.com/SubCodeAfrica/Tunneld/main/install.ps1 | iex
```

**Install specific version:**
```powershell
& ([scriptblock]::Create((iwr -useb https://raw.githubusercontent.com/SubCodeAfrica/Tunneld/main/install.ps1))) -Version "v1.0.0"
```

## Manual Installation

1. Go to the [releases page](https://github.com/SubCodeAfrica/Tunneld/releases/latest)
2. Download the appropriate binary for your platform:
   - **Linux AMD64**: `tunneld-linux-amd64`
   - **Linux ARM64**: `tunneld-linux-arm64`
   - **macOS Intel**: `tunneld-darwin-amd64`
   - **macOS Apple Silicon**: `tunneld-darwin-arm64`
   - **Windows AMD64**: `tunneld-windows-amd64.exe`
   - **Windows ARM64**: `tunneld-windows-arm64.exe`

3. Make it executable (Linux/macOS):
   ```bash
   chmod +x tunneld-*
   ```

4. Move to a directory in your PATH:
   ```bash
   # Linux/macOS
   sudo mv tunneld-* /usr/local/bin/tunneld
   ```

## Usage

After installation, run:
```bash
tunneld --help
```

## Available Versions

See all available versions on our [releases page](https://github.com/SubCodeAfrica/Tunneld/releases).

## Supported Platforms

- ✅ Linux (AMD64, ARM64)
- ✅ macOS (Intel, Apple Silicon)
- ✅ Windows (AMD64, ARM64)

---

**Latest Version**: [v1.0.2](https://github.com/SubCodeAfrica/Tunneld/releases/latest)
**Last Updated**: 2025-09-21 12:44:38 UTC
