{ pkgs, lib, ... }:
{
  vim = {

    # plugins
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;

    # theme 
    # use monokai with bacckground color to #000

    # try
    # lazygit.enable = true;
    lazy.enable = true;
    # snacks.enable = true;
    # harpoon.enable = true;
    # copilot.enable = true;

    # extraLuaFiles = [
    #   ./plugins/harpoon.lua
    # ];

    # harpoon
    navigation.harpoon = {
      enable = true;
      mappings = {
        listMarks = "<leader>m";
        markFile = "<leader>n";

        clearMark = "<leader>c";

        file1 = "<leader>h";
        file2 = "<leader>j";
        file3 = "<leader>k";
        file4 = "<leader>l";
        file5 = "<leader>H";
        file6 = "<leader>J";
        file7 = "<leader>K";
        file8 = "<leader>L";
      };

    };

    # Inject your dynamic loop and advanced functions here
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
