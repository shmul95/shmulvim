{ pkgs, lib, ... }:
{
  vim.globals = {
    mapleader = " "; # space
    shiftwidth = 4; # but 2 for yml, nix, etc
  };
}
