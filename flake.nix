{
  description = "Home Manager module for the shmulvim Neovim configuration";

  outputs = { self }:
    {
      homeManagerModules = {
        default = import ./nixos/modules/home-manager/shmulvim.nix;
      };
    };
}
