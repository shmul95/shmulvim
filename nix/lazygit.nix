{ pkgs, lib, ... }:
{
  vim.terminal.toggleterm.lazygit = {
    enable = true;
    mappings.open = "<leader>g";
    direction = "float";
  };
}
