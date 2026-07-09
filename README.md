# llama-cpp-bundle

llama.cpp (official master) + QLoRA training (cherry-pick from PR #22705).

## What's included

- `llama-server` — chat + embedding API server
- `llama-finetune-qlora` — QLoRA fine-tuning
- `llama.exe` — unified CLI
- `llama-bench`, `llama-quantize`, etc.

## Build

```powershell
.\build.ps1
```

Requires: Visual Studio Build Tools, CMake, Vulkan SDK.

## Upstream

https://github.com/ggerganov/llama.cpp
