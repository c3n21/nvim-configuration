{
  description = "NeoVim configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      neovim-nightly,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages."${system}".default = pkgs.wrapNeovimUnstable neovim-nightly.packages."${system}".default {
        autoconfigure = true;
      };
    };
}
