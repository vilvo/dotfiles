# SPDX-License-Identifier: MIT
{
  description = "declarations of machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let user = "vilvo";
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs user;
          modules = [({pkgs, ...}: {
            config = {
              nix.settings = {
                trusted-public-keys = [
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                ];
                substituters = [
                  "https://cache.nixos.org"
                  "https://nixpkgs-wayland.cachix.org"
                ];
              };
            };
            nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];
          })];
        }
      );
    };
}
