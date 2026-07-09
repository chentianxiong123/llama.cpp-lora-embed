$ErrorActionPreference = "Stop"
$env:HTTP_PROXY = "http://127.0.0.1:7897"
$env:HTTPS_PROXY = "http://127.0.0.1:7897"

# Setup MSVC environment
& "D:\devtools\VSBuildTools\VC\Auxiliary\Build\vcvars64.bat"

# Create build directory
New-Item -ItemType Directory -Path "build" -Force | Out-Null
Set-Location -LiteralPath "build"

# CMake configure with Vulkan
cmake .. `
  -G "Visual Studio 17 2022" `
  -DCMAKE_BUILD_TYPE=Release `
  -DLLAMA_VULKAN=ON `
  -DLLAMA_BUILD_SERVER=ON `
  -DLLAMA_BUILD_EXAMPLES=ON `
  -DLLAMA_FATAL_WARNINGS=OFF `
  -DLLAMA_NATIVE=OFF

if ($LASTEXITCODE -ne 0) { throw "CMake configure failed" }

# Build
cmake --build . --config Release --target llama-server --target llama-finetune-qlora -j

if ($LASTEXITCODE -ne 0) { throw "Build failed" }

Write-Host "`nBuild complete! Checking binaries..." -ForegroundColor Green
Get-ChildItem -Path "bin\Release\llama-server.exe","bin\Release\llama-finetune-qlora.exe","bin\Release\llama.exe" -ErrorAction SilentlyContinue | Select-Object Name, Length
