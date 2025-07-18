#!/bin/bash

# Claude Auto Commit SDK v0.1.0 - One-line Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/0xkaz/claude-auto-commit/main/scripts/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Installation directories
INSTALL_DIR="$HOME/.claude-auto-commit"
BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.claude-auto-commit"

# Function to print colored output
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to remove old CLI version
remove_old_version() {
    local old_locations=(
        "/usr/local/bin/claude-auto-commit"
        "/opt/homebrew/bin/claude-auto-commit"
        "$HOME/bin/claude-auto-commit"
    )
    
    for location in "${old_locations[@]}"; do
        if [[ -f "$location" ]]; then
            # Check if it's the old CLI version
            if grep -q "Version: 0.0.5\|VERSION=\"0.0.5\"" "$location" 2>/dev/null; then
                print_message "$YELLOW" "🗑️  Removing old CLI version from $location..."
                rm -f "$location" 2>/dev/null || sudo rm -f "$location" 2>/dev/null || {
                    print_message "$RED" "⚠️  Could not remove $location. Please remove manually:"
                    print_message "$RED" "   sudo rm $location"
                }
            fi
        fi
    done
}

# Function to detect shell and update profile
update_shell_profile() {
    local shell_profile=""
    
    if [[ "$SHELL" == *"zsh"* ]]; then
        shell_profile="$HOME/.zshrc"
    elif [[ "$SHELL" == *"bash"* ]]; then
        if [[ -f "$HOME/.bash_profile" ]]; then
            shell_profile="$HOME/.bash_profile"
        else
            shell_profile="$HOME/.bashrc"
        fi
    elif [[ "$SHELL" == *"fish"* ]]; then
        shell_profile="$HOME/.config/fish/config.fish"
    fi
    
    if [[ -n "$shell_profile" ]] && [[ -f "$shell_profile" ]]; then
        # Check if PATH already contains the bin directory
        if ! grep -q "$BIN_DIR" "$shell_profile"; then
            echo "" >> "$shell_profile"
            echo "# Claude Auto Commit SDK" >> "$shell_profile"
            if [[ "$SHELL" == *"fish"* ]]; then
                echo "set -gx PATH $BIN_DIR \$PATH" >> "$shell_profile"
            else
                echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$shell_profile"
            fi
            print_message "$GREEN" "✅ Updated $shell_profile with PATH"
        fi
    fi
}

# Banner
echo ""
print_message "$BLUE" "🚀 Claude Auto Commit SDK v0.1.1 Installer"
print_message "$BLUE" "=========================================="
echo ""

# Check prerequisites
print_message "$YELLOW" "📋 Checking prerequisites..."

# Check Node.js
if ! command_exists node; then
    print_message "$RED" "❌ Node.js is not installed. Please install Node.js 22.0.0 or later."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2)
NODE_MAJOR=$(echo $NODE_VERSION | cut -d'.' -f1)
if [ "$NODE_MAJOR" -lt 22 ]; then
    print_message "$RED" "❌ Node.js version 22.0.0 or later is required. Current version: $NODE_VERSION"
    exit 1
fi
print_message "$GREEN" "✅ Node.js $(node -v) found"

# Check npm
if ! command_exists npm; then
    print_message "$RED" "❌ npm is not installed. Please install npm."
    exit 1
fi
print_message "$GREEN" "✅ npm $(npm -v) found"

# Check git
if ! command_exists git; then
    print_message "$RED" "❌ Git is not installed. Please install git."
    exit 1
fi
print_message "$GREEN" "✅ Git $(git --version | cut -d' ' -f3) found"

# Check Claude Code SDK
if ! command_exists claude; then
    print_message "$YELLOW" "⚠️  Claude Code SDK not found. Installing..."
    npm install -g @anthropic-ai/claude-code
    if [ $? -eq 0 ]; then
        print_message "$GREEN" "✅ Claude Code SDK installed successfully"
    else
        print_message "$RED" "❌ Failed to install Claude Code SDK"
        exit 1
    fi
else
    print_message "$GREEN" "✅ Claude Code SDK found"
fi

# Check Claude CLI authentication
if ! command_exists claude; then
    print_message "$YELLOW" "⚠️  Claude CLI not found. Installing..."
    npm install -g @anthropic-ai/claude-code
else
    print_message "$GREEN" "✅ Claude CLI found"
fi

# Check if Claude is authenticated
if ! claude -p "test" >/dev/null 2>&1; then
    print_message "$YELLOW" "⚠️  Claude CLI not authenticated"
    echo "   Please run the following command after installation:"
    echo "   claude login"
    echo "   (Requires Claude Pro/Max subscription)"
    echo ""
fi

# Remove old CLI versions
print_message "$YELLOW" "🧹 Checking for old CLI versions..."
remove_old_version

# Create necessary directories
print_message "$YELLOW" "📁 Creating directories..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"
mkdir -p "$CONFIG_DIR/templates"

# Clone or download the repository
print_message "$YELLOW" "📥 Downloading Claude Auto Commit SDK..."

# Remove old installation if exists
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
fi

# Clone the repository
git clone https://github.com/0xkaz/claude-auto-commit.git "$INSTALL_DIR" 2>/dev/null || {
    # If git clone fails, try downloading as archive
    print_message "$YELLOW" "📦 Downloading as archive..."
    curl -fsSL https://github.com/0xkaz/claude-auto-commit/archive/main.tar.gz | tar -xz -C "$HOME/.tmp"
    mv "$HOME/.tmp/claude-auto-commit-main" "$INSTALL_DIR"
}

# Install dependencies
print_message "$YELLOW" "📦 Installing dependencies..."
cd "$INSTALL_DIR"
npm install --production

# Create symbolic link
print_message "$YELLOW" "🔗 Creating command link..."
ln -sf "$INSTALL_DIR/bin/claude-auto-commit" "$BIN_DIR/claude-auto-commit"
chmod +x "$BIN_DIR/claude-auto-commit"

# Create default config if not exists
if [ ! -f "$CONFIG_DIR/config.json" ]; then
    print_message "$YELLOW" "⚙️  Creating default configuration..."
    cat > "$CONFIG_DIR/config.json" << EOF
{
  "language": "en",
  "useEmoji": false,
  "conventionalCommit": false,
  "verbose": false
}
EOF
    print_message "$GREEN" "✅ Default configuration created"
fi

# Update shell profile
update_shell_profile

# Installation complete
echo ""
print_message "$GREEN" "🎉 Installation complete!"
echo ""
print_message "$BLUE" "📖 Quick Start:"
echo "   1. Authenticate with Claude (if not already done):"
echo "      claude login"
echo "      (Choose option 2: Claude app - requires Pro/Max subscription)"
echo ""
echo "   2. Use claude-auto-commit in any git repository:"
echo "      claude-auto-commit"
echo "      claude-auto-commit -l ja -e -c"
echo "      claude-auto-commit --help"
echo ""
echo "   3. Configure defaults:"
echo "      Edit ~/.claude-auto-commit/config.json"
echo ""

# Check if bin directory is in PATH
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
    print_message "$YELLOW" "⚠️  Please add $BIN_DIR to your PATH:"
    echo "   export PATH=\"$BIN_DIR:\$PATH\""
    echo "   Or restart your terminal to apply changes"
fi

print_message "$BLUE" "🔗 Documentation: https://github.com/0xkaz/claude-auto-commit"
echo ""