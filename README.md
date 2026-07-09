# llama.cpp-lora-embed-rx580

**基于 llama.cpp 的 RX580/RX590 本地 LoRA + Embedding 工具分支**

这个仓库是独立发行分支，不用于向上游 llama.cpp 合并。目标是保留 llama.cpp 主线能力，同时整理出适合 AMD RX580/RX590 级别本地机器使用的 LoRA、Q-LoRA 和 embedding/RAG 工作流。

## 用途

| 功能 | 二进制 | 说明 |
|------|--------|------|
| **Embedding 服务** | `llama-server --embedding` | 启动 OpenAI 兼容的嵌入 API，供 RAG、检索使用 |
| **LoRA 推理** | `llama-server --lora adapter.gguf` | 加载已训练的 LoRA 适配器做推理 |
| **Q-LoRA 微调** | `llama-finetune-qlora` | 在量化模型上训练 LoRA 适配器，支持 4bit/8bit |
| **通用 CLI** | `llama` | 统一命令行推理、量化、benchmark |

## 设计规则

- 仓库只放代码和可公开文档。
- 不提交模型权重、LoRA adapter、embedding dump、聊天数据、训练数据、图片或视频。
- 本地数据、输出、缓存、编译产物都必须留在 Git 之外。
- 默认服务目标是低成本本地实验，而不是云端大规模训练。
- RX580/RX590 上优先使用小模型、量化模型和可恢复的分步流程。

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

## 仓库卫生

`.gitignore` 默认排除：

- 模型和 LoRA 文件
- 图片、视频、音频等媒体文件
- 本地聊天记录和训练数据
- embedding dump / 向量数据库
- build 输出和二进制文件
- 本地临时目录和缓存

提交前检查：

```powershell
git status --short
git ls-files | rg -i "\.(png|jpe?g|webp|mp4|gguf|safetensors|bin)$"
```

## 关于

基于 [llama.cpp](https://github.com/ggerganov/llama.cpp) 构建，额外包含社区贡献的 Q-LoRA 训练功能，并针对 RX580/RX590 本地实验工作流做整理。
