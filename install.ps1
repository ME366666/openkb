# kb 一键安装脚本
# 远程: irm https://github.com/xxx/releases/latest/download/install.ps1 | iex
# 本地: .\install.ps1

$ErrorActionPreference = "Stop"
$installDir = "$env:USERPROFILE\.kb-bin"
$releaseUrl = "https://github.com/ME366666/openkb/releases/latest/download"

Write-Host "=== kb 课表工具 安装 ===" -ForegroundColor Cyan

# 1. 创建安装目录
if (!(Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

# 2. 判断本地还是远程安装
$myPath = $MyInvocation.MyCommand.Path
if ($myPath) {
    $localDir = Split-Path -Parent $myPath
}
if ($myPath -and (Test-Path "$localDir\kb.exe")) {
    Write-Host "本地安装..." -ForegroundColor Yellow
    Copy-Item "$localDir\kb.exe", "$localDir\*.dll" -Destination $installDir -Force
} else {
    Write-Host "下载中..." -ForegroundColor Yellow
    $zipPath = "$env:TEMP\kb.zip"
    Invoke-WebRequest -Uri "$releaseUrl/kb.zip" -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $installDir -Force
    Remove-Item $zipPath -Force
}

# 3. 添加到用户 PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$installDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$installDir", "User")
    $env:Path += ";$installDir"
    Write-Host "已添加 $installDir 到 PATH" -ForegroundColor Green
} else {
    Write-Host "PATH 已配置" -ForegroundColor Yellow
}

Write-Host "安装完成!  运行 kb init 开始" -ForegroundColor Green
