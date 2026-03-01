{ pkgs, lib, ... }:
{

  vim.navigation.harpoon = {
    enable = true;
    mappings = {
      listMarks = "<leader>m";
      markFile = "<leader>n";
      clearMarks = "<leader>c";

      # clearMarks = mkLuaBinding "<leader>c" /* lua */ ''
      #   function() require("harpoon.mark").clear_all() end
      # '' "Clear all marks [Harpoon]";

      # clearMarks = mkKeymap "n" "<leader>c" /* lua */ ''
      #   function() require("harpoon.mark").clear_all() end
      # '' { desc = "Clear Marks [Harpoon]"; };

      file1 = "<leader>h";
      file2 = "<leader>j";
      file3 = "<leader>k";
      file4 = "<leader>l";
    };

  };

  # extraLuaConfig = ''
  #   vim.keymap.set("n", "<leader>c", function() require("harpoon.mark").clear_all() end, { desc = })
  # '';
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
}
