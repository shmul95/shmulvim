#!/bin/bash
set -e

echo "🚀 Setting up your Neovim config..."

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create ~/.config if needed
mkdir -p "$HOME/.config"

# Symlink Neovim config
echo "🔗 Linking ~/.config/nvim -> \$REPO_DIR/nvim"
ln -sf "$REPO_DIR/nvim" "$HOME/.config/nvim"

echo "✅ Done! Start Neovim with: nvim"
