# shmulvim

📝 **shmulvim** is my personal Neovim configuration, fully versioned and portable. It includes custom settings, plugins, and a clean Lua/Vimscript setup for a fast and modern development experience.

This setup features:

* A complete Neovim config in `~/.config/nvim`
* Plugin management (compatible with `lazy.nvim`, `packer`, or `vim-plug`)
* Centralized for easy backup and reuse across systems

---

## 📦 Installation (fresh machine)

1. Clone this repo:
   ```bash
   git clone --recurse-submodules https://github.com/shmul95/shmulvim.git
   cd shmulvim
   ```
2. Run the installer:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

The script will:

* Install Neovim (and tools like `git` and `ripgrep`) using your system package manager, if `nvim` isn’t already installed.
* Create `~/.config` if needed.
* Backup any existing `~/.config/nvim` directory to `~/.config/nvim.backup.<timestamp>`.
* Symlink this repo’s `nvim/` directory to `~/.config/nvim`.

---

## 📁 Structure

```
shmulvim/
├── nvim/                  → Full Neovim config directory
│   ├── init.lua / init.vim
│   └── lua/ (if using Lua)
├── install.sh             → Symlink and setup script
```

---

## 🔧 What It Does

* Symlinks `nvim/` to `~/.config/nvim`
* Ensures a clean and portable Neovim setup
* Keeps all config under version control

---

## ✅ Requirements

* `neovim` (>= 0.8 recommended)
* Plugin manager of your choice (`lazy.nvim`, `packer.nvim`, or `vim-plug`)
* [Nerd Font](https://www.nerdfonts.com/) for enhanced UI

---

## 💬 License

MIT — fork, adapt, and make it yours.
