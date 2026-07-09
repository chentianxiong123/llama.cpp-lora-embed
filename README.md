# llama-lora-embed

**一个编译，两套核心功能：Q-LoRA 微调 + Embedding 服务**

基于 llama.cpp 官方主线，合入社区 Q-LoRA 训练补丁（PR #22705）。

## 用途

| 功能 | 二进制 | 说明 |
|------|--------|------|
| **Embedding 服务** | `llama-server --embedding` | 启动 OpenAI 兼容的嵌入 API，供 RAG、检索使用 |
| **LoRA 推理** | `llama-server --lora adapter.gguf` | 加载已训练的 LoRA 适配器做推理 |
| **Q-LoRA 微调** | `llama-finetune-qlora` | 在量化模型上训练 LoRA 适配器，支持 4bit/8bit |
| **通用 CLI** | `llama` | 统一命令行推理、量化、benchmark |

## Quick Start

### Embedding 服务

```powershell
.\llama-server.exe -m D:\models\qwen3-embedding-0.6b-q8_0.gguf --embedding --port 8081
```

### Q-LoRA 微调

```powershell
.\llama-finetune-qlora.exe -m base_model.gguf --train-file data.jsonl --lora-out my-adapter.gguf --lora-rank 16 -lr 2e-4
```

### LoRA 推理

```powershell
.\llama.exe -m base_model.gguf --lora my-adapter.gguf -p "prompt"
```

## 编译

```powershell
.\build.ps1
```

需安装：Visual Studio Build Tools、CMake、Vulkan SDK（可选）

## 关于

基于 [llama.cpp](https://github.com/ggerganov/llama.cpp) 构建，额外包含社区贡献的 Q-LoRA 训练功能。
