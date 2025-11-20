#!/usr/bin/env bash
set -e

echo "🚀 Setting up your Neovim config..."

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_neovim_and_tools() {
  if command -v nvim >/dev/null 2>&1; then
    echo "✔ Neovim already installed"
    return
  fi

  echo "📦 Installing Neovim (and tools)..."

  if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y neovim git ripgrep
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm neovim git ripgrep
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y neovim git ripgrep
  elif command -v zypper >/dev/null 2>&1; then
    sudo zypper install -y neovim git ripgrep
  elif command -v brew >/dev/null 2>&1; then
    brew install neovim git ripgrep
  else
    echo "⚠ Could not detect a supported package manager."
    echo "  Please install Neovim manually, then re-run this script."
  fi
}

install_neovim_and_tools

mkdir -p "$HOME/.config"

if [ -e "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
  backup="$HOME/.config/nvim.backup.$(date +%s)"
  echo "📁 Backing up existing ~/.config/nvim to $backup"
  mv "$HOME/.config/nvim" "$backup"
fi

echo "🔗 Linking ~/.config/nvim -> $REPO_DIR/nvim"
ln -sfn "$REPO_DIR/nvim" "$HOME/.config/nvim"

echo "✅ Done! Start Neovim with: nvim"
