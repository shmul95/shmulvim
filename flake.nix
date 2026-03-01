{
  description = "Nix flake for developing and testing the shmulvim Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, flake-utils, nvf, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        shmulvim =
          (nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [
              ./nix/config.nix
              ./nix/globals.nix

              ./nix/harpoon.nix
              ./nix/telescope.nix
              ./nix/treesitter.nix

              ./nix/monokai.nix

              ./nix/harpoon-extension.nix
            ];
          }).neovim;
      in { packages.default = shmulvim; }
    );
}
