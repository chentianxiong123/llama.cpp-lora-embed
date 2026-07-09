# Build llama-lora-embed: llama.cpp + QLoRA training + embedding server
$ErrorActionPreference = "Stop"
$env:HTTP_PROXY = "http://127.0.0.1:7897"
$env:HTTPS_PROXY = "http://127.0.0.1:7897"

& "D:\devtools\VSBuildTools\VC\Auxiliary\Build\vcvars64.bat"

New-Item -ItemType Directory -Path "build" -Force | Out-Null
Set-Location -LiteralPath "build"

cmake .. `
  -G "Visual Studio 17 2022" `
  -DCMAKE_BUILD_TYPE=Release `
  -DGGML_VULKAN=ON `
  -DLLAMA_BUILD_SERVER=ON `
  -DLLAMA_BUILD_EXAMPLES=ON `
  -DLLAMA_FATAL_WARNINGS=OFF `
  -DLLAMA_NATIVE=OFF

cmake --build . --config Release --target llama-server --target llama-finetune-qlora -j

Write-Host "Build complete." -ForegroundColor Green
