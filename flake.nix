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
            nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];
          })];
        }
      );
    };
}
