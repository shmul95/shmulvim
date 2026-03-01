{ pkgs, lib, ... }:
{
  vim = {

    # globals
    globals = {
      mapleader = " "; # space
      shiftwidth = 4; # but 2 for yml, nix, etc
    };

    # plugins
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;

    # telescope
    telescope = {
      enable = true;
      mappings = {
        findFiles = "<leader>f";
        liveGrep = "<leader>r";
        buffers = "<leader>b";
        findProjects = null;
        helpTags = null;
        open = null;
        resume = null;

        gitFiles = null;
        gitCommits = null;
        gitBufferCommits = null;
        gitBranches = null;
        gitStatus = null;
        gitStash = null;

        lspDocumentSymbols = null;
        lspWorkspaceSymbols = null;
        lspReferences = null;
        lspImplementations = null;
        lspDefinitions = null;
        lspTypeDefinitions = null;
        diagnostics = null;

        treesitter = null;
      };
    };

    # theme 
    # use monokai with bacckground color to #000

    # treesitter
    languages = {
      enableTreesitter = true;

      nix.enable = true;
      python.enable = true;
      clang.enable = true;
      # cpp.enable = true;
      rust.enable = true;
      haskell.enable = true;
    };

    # try
    # lazygit.enable = true;
    lazy.enable = true;
    # snacks.enable = true;
    # harpoon.enable = true;
    # copilot.enable = true;

    extraLuaFiles = [
      ./plugins/harpoon.lua
    ];

    # # harpoon
    # navigation.harpoon = {
    #   enable = true;
    #   mappings = {
    #     listMarks = "<leader>m";
    #     markFile = "<leader>n";
    #   };
    # };
    #
    # # Inject your dynamic loop and advanced functions here
    # extraLuaFiles = /* lua */ ''
    #   local ui = require("harpoon.ui")
    #   local mark = require("harpoon.mark")
    #
    #   -- Your existing logic
    #   local nav_keys = { "h", "j", "k", "l", "H", "J", "K", "L" }
    #   for i, key in ipairs(nav_keys) do
    #     vim.keymap.set("n", "<leader>" .. key, function() ui.nav_file(i) end, { desc = "Harpoon nav" })
    #   end
    #
    #   -- Don't forget your helper function
    #   vim.keymap.set("n", "<leader>c", function() mark.clear_all() end, { desc = "Harpoon clear" })
    # '';

  };
}
