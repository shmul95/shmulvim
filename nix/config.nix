{ pkgs, lib, ... }:
{
  vim = {
    lsp.enable = true;
    lazy.enable = true;

    globals = {
      mapleader = " "; # space
      shiftwidth = 4; # but 2 for yml, nix, etc
    };

    extraLuaFiles = [
      ./lua/clipboard.lua
      ./lua/keymap.lua
    ];

  };
}
