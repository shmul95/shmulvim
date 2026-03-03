{ pkgs, lib, ... }:
{
  vim = {
    lsp.enable = true;
    lazy.enable = true;

    clipboard = {
       enable = true;
       providers.wl-copy.enable = true;
       registers = "unnamedplus";
    };

    globals = {
      mapleader = " "; # space
      shiftwidth = 4; # but 2 for yml, nix, etc
    };

    extraLuaFiles = [
      ./lua/keymap.lua
    ];

  };
}
