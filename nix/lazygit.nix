{ pkgs, lib, ... }:
{
  vim.terminal.toggleterm = {
    enable = true;
    lazygit = {
      enable = true;
      package = pkgs.lazygit;
      mappings.open = "<leader>g";
      direction = "float";
    };
  };
}
