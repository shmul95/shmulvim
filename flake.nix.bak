{
  description = "Nix flake for developing and testing the shmulvim Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        lspAndToolchain = with pkgs; [
          bash-language-server
          clang-tools
          dockerfile-language-server-nodejs
          gopls
          marksman
          nodePackages.vscode-css-languageserver-bin
          nodePackages.vscode-html-languageserver-bin
          nodePackages.vscode-json-languageserver-bin
          pyright
          rust-analyzer
          sqls
          tailwindcss-language-server
          lua-language-server
          yaml-language-server
        ];

        editorTools = with pkgs; [
          neovim
          git
          ripgrep
          fd
          lazygit
          tree-sitter
          stylua
          shellcheck
          shfmt
          python311Packages.flake8
          nodejs_20
          gcc
          gnumake
          pkg-config
        ];

        fmtScript = pkgs.writeShellApplication {
          name = "fmt-shmulvim";
          runtimeInputs = [ pkgs.stylua ];
          text = ''
            stylua --glob '**/*.lua' ${./nvim}
          '';
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "shmulvim";
          packages = editorTools ++ lspAndToolchain;

          shellHook = ''
            echo "shmulvim devshell ready – core tooling (nvim, stylua, ripgrep, LSPs) is on PATH."
          '';
        };

        formatter = fmtScript;

        checks = {
          stylua = pkgs.runCommand "stylua-check" { buildInputs = [ pkgs.stylua ]; } ''
            stylua --check --glob '**/*.lua' ${./nvim}
            touch $out
          '';
        };
      });
}
