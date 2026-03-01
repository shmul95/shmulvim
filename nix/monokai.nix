{ config, lib, pkgs, ... }:
let
  inherit (lib.types) enum;
  themeOptions = config.vim.theme;
in {

  # 1. add to the enum list
  # options.vim.theme.name = lib.mkOption {
  #   type = enum [ "monokai" ];
  # };

  # 2. setup the theme
  config =  lib.mkIf (config.vim.theme.name == "monokai") {
    vim = {

      extraPlugins.monokai-nvim = {
        package = pkgs.vimUtils.buildVimPlugin {
          name = "monokai-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "tanvirtin";
            repo = "monokai.nvim";
            rev = "73321b66140ceda63d5b951f84ce75d3bfdf91b3";
            hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          };
        };

        after = /* lua */ ''
          require("monokai").setup({
            -- We map the 'style' to the palette. 
            -- Note: You might need to adjust this depending on if you want classic, pro, etc.
            palette = require("monokai").classic,
            -- Custom background override for your #000000 requirement
            custom_hlgroups = {
              Normal = { bg = "#000000" },
              NormalNC = { bg = "#000000" },
            }
          })
          vim.cmd("colorscheme monokai")
        '';

      };
    };

  };
}
