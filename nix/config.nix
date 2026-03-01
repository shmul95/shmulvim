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

    # snacks.enable = true;
    # copilot.enable = true;
  };
}
