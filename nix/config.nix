{ pkgs, lib, ... }:
{
  vim = {

    # plugins
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;

    theme = {
      enable = true;
      name = "dracula";
    };

    lazy.enable = true;

    terminal.toggleterm.lazygit = {
      enable = true;
      mappings.open = "<leader>g";
      direction = "float";
    };

    # snacks.enable = true;
    # copilot.enable = true;
  };
}
