{ pkgs, ... }:
{
  theme = {
    enable = true;
    name = "dracula";
    # don't work for some reason
    extraConfig = /* lua */ ''
      vim.g.dracula_colorterm = 0
      vim.g.dracula_italic = true

      vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
    '';
  };
}
