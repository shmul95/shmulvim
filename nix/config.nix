{ pkgs, lib, ... }:
{
  vim = {
    lsp.enable = true;
    lazy.enable = true;

    extraLuaFiles = [
      ./lua/keymap.lua
    ];
  };
}
