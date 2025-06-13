# Claude Auto-Commit Reference (v0.1.0)

Claude Code SDKを活用した高性能な自動コミットツールの技術仕様です。

## 基本使用方法

```bash
# 基本実行
claude-auto-commit

# NPMグローバルインストール後
npm install -g claude-auto-commit
claude-auto-commit

# ワンタイム実行
curl -fsSL https://raw.githubusercontent.com/0xkaz/claude-auto-commit/main/scripts/run-once.sh | bash
```

## 高度なオプション

```bash
# 日本語 + 絵文字 + Conventional Commits
claude-auto-commit -l ja -e -c

# 特定コミットタイプで自動プッシュ
claude-auto-commit -t feat --push

# ドライラン（プレビューのみ）
claude-auto-commit --dry-run

# 詳細実行情報とパフォーマンス表示
claude-auto-commit --verbose

# テンプレート使用
claude-auto-commit --template my-template

# テンプレート保存（ドライラン時）
claude-auto-commit --dry-run --save-template feature-update
```

## 全オプション

| オプション | 短縮形 | 説明 | デフォルト |
|-----------|--------|------|----------|
| `--language <lang>` | `-l` | 言語 (en/ja) | `en` |
| `--emoji` | `-e` | 絵文字使用 | `false` |
| `--conventional` | `-c` | Conventional Commits | `false` |
| `--type <type>` | `-t` | コミットタイプ | 自動 |
| `--dry-run` | `-d` | プレビューのみ | `false` |
| `--verbose` | `-v` | 詳細出力 | `false` |
| `--push` | `-p` | 自動プッシュ | `false` |
| `--template <name>` | | テンプレート使用 | なし |
| `--save-template <name>` | | テンプレート保存 | なし |
| `--list-templates` | | テンプレート一覧 | - |
| `--help` | `-h` | ヘルプ表示 | - |

## 機能

### 🧠 AI機能
- ✅ Claude Code SDKによる智的なコミットメッセージ生成
- ✅ 並列処理とキャッシュによる高速化
- ✅ 指数バックオフによるリトライ機能
- ✅ タイムアウト機能と堅牢なエラーハンドリング

### 📝 コミット機能
- ✅ 変更がない場合の自動終了
- ✅ 自動ステージング
- ✅ Conventional Commits対応
- ✅ 絵文字サポート
- ✅ ドライランモード
- ✅ オプショナル自動プッシュ

### 🌐 多言語・設定
- ✅ 多言語対応（英語・日本語）
- ✅ JSON設定ファイル（キャッシュ機能付き）
- ✅ テンプレートシステム
- ✅ 詳細ログとパフォーマンス測定

### 📦 インストール・配布
- ✅ NPMパッケージ対応
- ✅ ワンライナーインストーラー
- ✅ ワンタイム実行スクリプト
- ✅ ES Modules + Node.js 22+対応

## 使用例

### 日常的な開発
```bash
claude-auto-commit  # 最もシンプル
```

### フィーチャー開発
```bash
claude-auto-commit -t feat -e --push
```

### バグ修正
```bash
claude-auto-commit -t fix -c -l en
```

### テンプレート活用
```bash
# テンプレート保存
claude-auto-commit --dry-run --save-template hotfix

# テンプレート使用
claude-auto-commit --template hotfix
```

## 技術仕様

### 依存関係
- **Node.js**: 22.0.0以上
- **@anthropic-ai/claude-code**: ^1.0.22
- **Git**: 任意のバージョン

### 設定ファイル
- **場所**: `~/.claude-auto-commit/config.json`
- **テンプレート**: `~/.claude-auto-commit/templates/`
- **キャッシュ**: メモリ内、5分間TTL

### パフォーマンス
- **並列処理**: Git コマンドの並列実行
- **キャッシュ**: 設定ファイル、Git 結果のキャッシュ
- **リトライ**: 最大3回、指数バックオフ
- **タイムアウト**: 30秒（設定可能）

### 環境変数
- **ANTHROPIC_API_KEY**: 必須、Claude API キー