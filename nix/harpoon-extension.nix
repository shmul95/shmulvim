{ config, lib, ... }:
let
  # Re-import the nvf helper library you need
  inherit (lib.nvim.binds) mkMappingOption mkKeymap;
  inherit (lib.modules) mkIf;
in {
  # 1. Define the new 'clearMarks' option in the existing namespace
  options.vim.navigation.harpoon.mappings = {
    clearMarks = mkMappingOption "Clear all marks [Harpoon]" "<leader>c";
  };

  # 2. Add the implementation logic
  config = mkIf config.vim.navigation.harpoon.enable {
    vim.lazy.plugins.harpoon = {
      keys = [
        (mkKeymap "n" config.vim.navigation.harpoon.mappings.clearMarks 
          "<Cmd>lua require('harpoon.mark').clear_all()<CR>" 
          { desc = "Clear Marks [Harpoon]"; })
      ];
    };
  };
}
