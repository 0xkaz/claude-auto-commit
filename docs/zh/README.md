# Claude Auto-Commit

<div align="center">

![Claude Auto-Commit Hero](../images/hero-banner.png)

🤖 **使用Claude Code SDK的AI驱动Git提交消息生成器**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/release/0xkaz/claude-auto-commit.svg)](https://github.com/0xkaz/claude-auto-commit/releases)
[![npm version](https://img.shields.io/npm/v/claude-auto-commit.svg)](https://www.npmjs.com/package/claude-auto-commit)
[![GitHub stars](https://img.shields.io/github/stars/0xkaz/claude-auto-commit.svg)](https://github.com/0xkaz/claude-auto-commit/stargazers)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-blue.svg)](https://github.com/0xkaz/claude-auto-commit)
[![Node.js](https://img.shields.io/badge/Node.js-22%2B-green.svg)](https://nodejs.org)
[![Claude Code SDK](https://img.shields.io/badge/Powered%20by-Claude%20Code%20SDK-orange.svg)](https://docs.anthropic.com/en/docs/claude-code)

</div>

**语言**: [English](../en/README.md) | [日本語](../ja/README.md)

Claude Auto-Commit是一个开源命令行工具，将AI驱动的提交消息生成集成到您的Git工作流程中。通过分析您的代码更改，使用Claude Code SDK创建高性能、可靠且有意义且符合上下文的提交消息。

## 🌟 转变您的提交历史

<div align="center">

![Before and After Comparison](../images/demo-before-after-english.png)

*告别模糊的提交消息。让Claude AI编写有意义的提交，讲述您代码的故事。*

</div>

## 🚀 快速开始

### 安装选项

**方法1：一键安装（推荐）**
```bash
curl -fsSL https://raw.githubusercontent.com/0xkaz/claude-auto-commit/main/scripts/install.sh | bash
```

**方法2：NPM全局安装**
```bash
npm install -g claude-auto-commit
```

**方法3：一次性执行（无需安装）**
```bash
curl -fsSL https://raw.githubusercontent.com/0xkaz/claude-auto-commit/main/scripts/run-once.sh | bash
```

### 基本用法

```bash
# 分析更改并生成提交消息
claude-auto-commit

# 中文界面，表情符号和常规提交格式
claude-auto-commit -l ja -e -c

# 自定义提交类型并自动推送
claude-auto-commit -t feat --push
# 生成提交消息并推送
claude-auto-commit

# 使用自定义选项
claude-auto-commit -l zh -e -t feat
```

## ✨ 功能特性

- 🧠 **AI驱动**: 使用Claude CLI生成智能提交消息
- 🌍 **多语言支持**: 支持中文、英语、日语、阿拉伯语、西班牙语、法语
- 📝 **约定式提交**: 可选的约定式提交格式
- 🔄 **自动更新**: 每日自动更新（可配置）
- 🎯 **智能分析**: 分析代码更改、文件类型和模式
- ⚡ **快速轻量**: 为日常开发工作流程优化
- 🛠️ **高度可配置**: 丰富的自定义选项

## 📋 系统要求

- Git仓库
- 已安装并配置[Claude CLI](https://docs.anthropic.com/claude/cli)
- Bash shell（macOS、Linux、WSL）

## 🎯 使用示例

### 基本用法
```bash
# 使用自动生成消息的简单提交
claude-auto-commit

# 自定义分支和表情符号
claude-auto-commit -b develop -e

# 中文约定式提交
claude-auto-commit -l zh -c -t feat

# 自定义消息，不推送
claude-auto-commit -m "自定义提交消息" -n
```

### 高级选项
```bash
# 手动暂存和详细输出
claude-auto-commit -s -v

# 热修复的自定义前缀
claude-auto-commit -p "[HOTFIX]" -t fix

# 更新工具
claude-auto-commit --update
```

## 🔧 安装方法

### 方法1: 一键安装（推荐）
```bash
curl -fsSL https://claude-auto-commit.0xkaz.com/install.sh | bash
```

### 方法2: 手动下载
```bash
# 为您的平台下载
curl -L -o claude-auto-commit https://github.com/0xkaz/claude-auto-commit/releases/latest/download/claude-auto-commit-$(uname -s)-$(uname -m)
chmod +x claude-auto-commit
sudo mv claude-auto-commit /usr/local/bin/
```

### 方法3: NPX（Node.js用户）
```bash
npx claude-auto-commit@latest
```

## ⚙️ 配置

创建 `~/.claude-auto-commit/config.yml`:

```yaml
auto_update:
  enabled: true
  frequency: daily  # daily/weekly/manual/always
  silent: false

defaults:
  language: zh
  branch: main
  emoji: false
  conventional: false

git:
  auto_stage: true
  auto_push: true
```

## 📖 所有选项

| 选项 | 说明 | 默认值 |
|------|------|--------|
| `-b, --branch <branch>` | 推送目标分支 | `main` |
| `-l, --language <lang>` | 语言 (zh/en/ja/ar/es/fr) | `en` |
| `-e, --emoji` | 使用表情符号 | `false` |
| `-n, --no-push` | 不推送 | `false` |
| `-s, --no-stage` | 手动暂存 | `false` |
| `-m, --message <msg>` | 自定义消息 | Claude生成 |
| `-t, --type <type>` | 提交类型 | 自动 |
| `-c, --conventional` | 约定式提交 | `false` |
| `-p, --prefix <prefix>` | 前缀 | 无 |
| `-v, --verbose` | 详细输出 | `false` |
| `--update` | 立即更新 | - |
| `--no-update` | 跳过本次更新 | - |
| `--version` | 显示版本 | - |
| `-h, --help` | 显示帮助 | - |

## 🌟 特性详解

### 智能提交消息生成
Claude AI分析代码更改并考虑以下因素生成消息：
- 更改文件的类型
- 添加、修改、删除的行数
- 实际代码差异
- 项目上下文

### 多语言支持
为每种语言的编程社区文化生成适合的消息：
- **中文**: 技术性强，表达直接
- **英语**: 简洁标准的表达
- **日语**: 礼貌详细的说明

### 自动更新系统
- 每日自动更新检查
- 无缝后台更新
- 失败时自动回滚

## 🤝 贡献

欢迎贡献！请参阅[CONTRIBUTING.md](../../CONTRIBUTING.md)了解详情。

## 📄 许可证

本项目使用MIT许可证 - 详见[LICENSE](../../LICENSE)文件。

## 🙏 致谢

- [Anthropic](https://anthropic.com) 的Claude CLI
- [约定式提交](https://conventionalcommits.org) 规范
- 开源社区的启发

---

**为开发者社区倾情打造 ❤️**

[报告问题](https://github.com/0xkaz/claude-auto-commit/issues) | [功能请求](https://github.com/0xkaz/claude-auto-commit/issues/new?template=feature_request.md)