# SPDX-License-Identifier: MIT

{ lib, inputs, nixpkgs, user, ... }:

let
  system = "x86_64-linux";

  # ssh private key path for remote builds
  # arg to generic common/remote_builders.nix module
  # TODO: learn yubikeys with nixos
  path_to_remotebuilder_key = "/home/${user}/.ssh/id_ed25519_arm_cloud";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {

  blop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./blop
      ./configuration.nix
      ./networking.nix
    ];
  };

  blip = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user path_to_remotebuilder_key; };
    modules = [
      ./blip
      ./configuration.nix
      ./networking.nix
    ];
  };

  carrie = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./carrie
      ./configuration.nix
      ./networking.nix
    ];
  };
}
