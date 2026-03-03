{ pkgs, lib, ... }:
{
  vim.languages = {
    enableTreesitter = true;

    nix.enable = true;
    python.enable = true;
    clang.enable = true;
    rust.enable = true;
    # haskell.enable = true;  # Disabled to save ~13GB (HLS + toolchain)
    assembly.enable = true;
  };
}
