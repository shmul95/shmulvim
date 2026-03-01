{ pkgs, lib, ... }:
{
  vim = {
    # plugins
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;

    # treesitter
    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
      python.enable = true;
      c.enable = true;
      cpp.enable = true;
      rust.enable = true;
      haskell.enable = true;
    };

    # try
    lazygit.enable = true;
    snacks.enable = true;
    harpoon.enable = true;
    copilot.enable = true;

    # maybe ?
    # treesitter.enable = true;

    # theme 
    # use monokai with bacckground color to #000
  };
}
