{ pkgs, lib, ... }:
{
  vim = {

    # plugins
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;

    # theme 
    theme = {
      enable = true;
      name = "monokai";
    };

    # try
    # lazygit.enable = true;
    lazy.enable = true;
    # snacks.enable = true;
    # copilot.enable = true;
  };
}
