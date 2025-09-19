param(
    [string]$Version = "latest"
)

$ErrorActionPreference = "Stop"

if ($Version -eq "latest") {
    Write-Host "Installing latest version of TunnelAfrica Client (tunneld) for Windows..." -ForegroundColor Yellow
} else {
    Write-Host "Installing TunnelAfrica Client (tunneld) $Version for Windows..." -ForegroundColor Yellow
}

$arch = $env:PROCESSOR_ARCHITECTURE
if ($arch -eq "AMD64") {
    $arch = "amd64"
} elseif ($arch -eq "ARM64") {
    $arch = "arm64"
} else {
    Write-Host "Unsupported architecture: $arch" -ForegroundColor Red
    exit 1
}

$binaryName = "tunneld-windows-$arch.exe"

if ($Version -eq "latest") {
    $binaryUrl = "https://github.com/SubCodeAfrica/Tunneld/releases/latest/download/$binaryName"
} else {
    $binaryUrl = "https://github.com/SubCodeAfrica/Tunneld/releases/download/$Version/$binaryName"
}

$installDir = "$env:ProgramFiles\TunnelAfrica"
$installPath = "$installDir\tunneld.exe"

Write-Host "Downloading from $binaryUrl..." -ForegroundColor Yellow

if (!(Test-Path $installDir)) {
    New-Item -ItemType Directory -Force -Path $installDir | Out-Null
}

try {
    Invoke-WebRequest -Uri $binaryUrl -OutFile $installPath -UseBasicParsing
} catch {
    Write-Host "Failed to download binary: $_" -ForegroundColor Red
    Write-Host "Please check if the version exists." -ForegroundColor Red
    exit 1
}

$currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
if ($currentPath -notlike "*$installDir*") {
    Write-Host "Adding to system PATH..." -ForegroundColor Yellow
    [Environment]::SetEnvironmentVariable("PATH", "$currentPath;$installDir", "Machine")
    $env:PATH = "$env:PATH;$installDir"
}

Write-Host "✅ tunneld installed successfully!" -ForegroundColor Green
Write-Host "Run 'tunneld --help' to get started." -ForegroundColor Green
Write-Host "Note: You may need to restart your terminal for PATH changes to take effect." -ForegroundColor Yellow

try {
    $version = & "$installPath" --version 2>$null
    Write-Host "Installed version: $version" -ForegroundColor Green
} catch {
    # Version command might not be available
}
