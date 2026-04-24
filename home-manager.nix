{ nvf }:

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf mkOption types optional optionalString;

  cfg = config.programs.shmulvim;

  # ── nvf module definitions (built from cfg values) ───────────────────

  coreModule = {
    vim = {
      lsp.enable = true;
      lazy.enable = true;

      options = {
        scrolloff = cfg.scrolloff;
      };

      globals = {
        mapleader = cfg.leader;
        shiftwidth = cfg.shiftwidth;
        shmulvim_clipboard_provider = cfg.clipboard.provider;
        shmulvim_clipboard_register = cfg.clipboard.register;
      };

      extraLuaFiles =
        optional cfg.clipboard.enable ./nix/lua/clipboard.lua
        ++ [ ./nix/lua/keymap.lua ];
    };
  };

  themeModule = {
    vim.theme = {
      enable = true;
      name   = cfg.theme.name;
      extraConfig = optionalString (cfg.theme.name == "dracula") ''
        vim.g.dracula_colorterm = ${if cfg.theme.enableColorterm then "1" else "0"}
        vim.g.dracula_italic = ${if cfg.theme.enableItalic then "true" else "false"}
      '';
    };
  };

  copilotModule = {
    vim.assistant.copilot = {
      enable = true;
      setupOpts.suggestion = {
        enabled      = true;
        auto_trigger = cfg.copilot.autoTrigger;
        keymap       = cfg.copilot.keymaps;
      };
    };
  };

  lazygitModule = {
    vim.terminal.toggleterm = {
      enable = true;
      lazygit = {
        enable          = true;
        package         = pkgs.lazygit;
        mappings.open   = cfg.lazygit.keymap;
        direction       = cfg.lazygit.direction;
      };
    };
  };

  harpoonModule = {
    vim.navigation.harpoon = {
      enable   = true;
      mappings = {
        listMarks  = cfg.harpoon.keymaps.listMarks;
        markFile   = cfg.harpoon.keymaps.markFile;
        clearMarks = cfg.harpoon.keymaps.clearMarks;
        file1      = cfg.harpoon.keymaps.file1;
        file2      = cfg.harpoon.keymaps.file2;
        file3      = cfg.harpoon.keymaps.file3;
        file4      = cfg.harpoon.keymaps.file4;
      };
    };
  };

  # Inlined from nix/harpoon-extension.nix — must stay a function so nvf's
  # module system resolves lib.nvim.binds correctly.
  harpoonExtensionModule = { config, lib, ... }: {
    options.vim.navigation.harpoon.mappings = {
      clearMarks = lib.nvim.binds.mkMappingOption
        "Clear all marks [Harpoon]"
        cfg.harpoon.keymaps.clearMarks;
    };
    config = lib.mkIf config.vim.navigation.harpoon.enable {
      vim.lazy.plugins.harpoon = {
        keys = [
          (lib.nvim.binds.mkKeymap "n"
            config.vim.navigation.harpoon.mappings.clearMarks
            "<Cmd>lua require('harpoon.mark').clear_all()<CR>"
            { desc = "Clear Marks [Harpoon]"; })
        ];
      };
    };
  };

  telescopeModule = {
    vim.telescope = {
      enable   = true;
      mappings = {
        findFiles  = cfg.telescope.keymaps.findFiles;
        liveGrep   = cfg.telescope.keymaps.liveGrep;
        buffers    = cfg.telescope.keymaps.buffers;
        # Explicitly disable all other built-in telescope mappings
        findProjects         = null;
        helpTags             = null;
        open                 = null;
        resume               = null;
        gitFiles             = null;
        gitCommits           = null;
        gitBufferCommits     = null;
        gitBranches          = null;
        gitStatus            = null;
        gitStash             = null;
        lspDocumentSymbols   = null;
        lspWorkspaceSymbols  = null;
        lspReferences        = null;
        lspImplementations   = null;
        lspDefinitions       = null;
        lspTypeDefinitions   = null;
        diagnostics          = null;
        treesitter           = null;
      };
    };
  };

  treesitterModule = {
    vim.languages = {
      enableTreesitter = cfg.languages.enableTreesitter;
      nix.enable       = builtins.elem "nix"      cfg.languages.list;
      python.enable    = builtins.elem "python"   cfg.languages.list;
      clang.enable     = builtins.elem "clang"    cfg.languages.list;
      rust.enable      = builtins.elem "rust"     cfg.languages.list;
      bash.enable      = builtins.elem "bash"     cfg.languages.list;
      assembly.enable  = builtins.elem "assembly" cfg.languages.list;
      haskell.enable   = builtins.elem "haskell"  cfg.languages.list;
    };
  };

  gitsignsModule = {
    vim.git = {
      enable         = true;
      gitsigns.enable = true;
    };
  };

  explorerModule = {
    vim.extraPlugins = {
      snacks-nvim = {
        package = pkgs.vimPlugins.snacks-nvim;
        setup   = /* lua */ ''
          require('snacks').setup({
            explorer = { enabled = true },
            picker   = {
              enabled = true,
              sources = {
                explorer = {
                  auto_close = true,
                  jump = { close = true },
                },
              },
            },
          })

          vim.keymap.set("n", "${cfg.explorer.keymap}", function()
            Snacks.explorer()
          end, { desc = "Toggle file explorer" })
        '';
      };
    };
  };

  extraConfigModule = {
    vim.luaConfigRC.shmulvim-extra = cfg.extraConfig;
  };

  nvfModules =
    [ coreModule themeModule treesitterModule ]
    ++ optional cfg.copilot.enable  copilotModule
    ++ optional cfg.lazygit.enable  lazygitModule
    ++ optional cfg.harpoon.enable  harpoonModule
    ++ optional cfg.harpoon.enable  harpoonExtensionModule
    ++ optional cfg.telescope.enable telescopeModule
    ++ optional cfg.gitsigns.enable  gitsignsModule
    ++ optional cfg.explorer.enable  explorerModule
    ++ optional (cfg.extraConfig != "") extraConfigModule;

  shmulvimPackage =
    (nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = nvfModules;
    }).neovim;

in {
  options.programs.shmulvim = {
    enable = mkEnableOption "shmulvim Neovim configuration" // { default = true; };

    installPackage = mkOption {
      type    = types.bool;
      default = false;
      description = "Install the shmulvim Neovim package into home.packages.";
    };

    clipboard = {
      enable = mkOption {
        type    = types.bool;
        default = true;
      };
      provider = mkOption {
        type    = types.enum [ "auto" "wl-copy" "xclip" "clip.exe" "win32yank.exe" ];
        default = "auto";
        description = "Clipboard provider. `auto` prefers Windows clipboard on WSL, then Wayland, then xclip.";
      };
      register = mkOption {
        type    = types.str;
        default = "unnamedplus";
      };
    };

    leader = mkOption {
      type    = types.str;
      default = " ";
      description = "The Neovim leader key.";
    };

    shiftwidth = mkOption {
      type    = types.int;
      default = 4;
    };

    scrolloff = mkOption {
      type    = types.int;
      default = 5;
    };

    theme = {
      name = mkOption {
        type    = types.str;
        default = "dracula";
      };
      enableItalic = mkOption {
        type    = types.bool;
        default = true;
        description = "Enable italic text in dracula theme.";
      };
      enableColorterm = mkOption {
        type    = types.bool;
        default = false;
        description = "Enable dracula_colorterm (set to false for most terminals).";
      };
    };

    languages = {
      list = mkOption {
        type    = types.listOf (types.enum [
          "nix" "python" "clang" "rust" "bash" "assembly" "haskell"
        ]);
        default = [ "nix" "python" "clang" "rust" "bash" "assembly" ];
        description = ''
          Programming languages to enable (LSP + treesitter).
          Note: haskell pulls ~13 GB of HLS toolchain — omit unless needed.
        '';
      };
      enableTreesitter = mkOption {
        type    = types.bool;
        default = true;
      };
    };

    copilot = {
      enable = mkOption { type = types.bool; default = true; };
      autoTrigger = mkOption {
        type    = types.bool;
        default = true;
        description = "Show copilot suggestions automatically as you type.";
      };
      keymaps = mkOption {
        type    = types.attrsOf types.str;
        default = {
          accept  = "<C-l>";
          next    = "<C-j>";
          prev    = "<C-k>";
          dismiss = "<C-h>";
        };
      };
    };

    lazygit = {
      enable    = mkOption { type = types.bool; default = true; };
      keymap    = mkOption { type = types.str;  default = "<leader>g"; };
      direction = mkOption {
        type    = types.enum [ "float" "horizontal" "vertical" ];
        default = "float";
      };
    };

    harpoon = {
      enable  = mkOption { type = types.bool; default = true; };
      keymaps = mkOption {
        type    = types.attrsOf types.str;
        default = {
          listMarks  = "<leader>m";
          markFile   = "<leader>n";
          clearMarks = "<leader>c";
          file1      = "<leader>h";
          file2      = "<leader>j";
          file3      = "<leader>k";
          file4      = "<leader>l";
        };
      };
    };

    telescope = {
      enable  = mkOption { type = types.bool; default = true; };
      keymaps = mkOption {
        type    = types.attrsOf types.str;
        default = {
          findFiles = "<leader>f";
          liveGrep  = "<leader>r";
          buffers   = "<leader>b";
        };
      };
    };

    gitsigns = {
      enable = mkOption { type = types.bool; default = true; };
    };

    explorer = {
      enable = mkOption { type = types.bool; default = true; };
      keymap = mkOption { type = types.str;  default = "<leader>e"; };
    };

    extraConfig = mkOption {
      type    = types.lines;
      default = "";
      description = "Extra Lua configuration appended after shmulvim setup.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = optional cfg.installPackage shmulvimPackage;
  };
}
