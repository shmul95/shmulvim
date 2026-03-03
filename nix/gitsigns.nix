{ pkgs, lib, ... }:
{
  vim.git = {
    enable = true;
    gitsigns = {
      enable = true;
    };
  };
}