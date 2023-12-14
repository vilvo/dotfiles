# SPDX-License-Identifier: MIT
{
  lib,
  inputs,
  nixpkgs,
  user,
  apple-silicon,
  jetpack-nixos,
  ...
}: let
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
    specialArgs = {inherit inputs user;};
    modules = [
      ./blop
      ./configuration.nix
    ];
  };

  blip = lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs user path_to_remotebuilder_key;};
    modules = [
      ./blip
      ./configuration.nix
    ];
  };

  carrie = lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs user;};
    modules = [
      ./carrie
      ./configuration.nix
    ];
  };

  blub = lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = {inherit inputs user;};
    modules = [
      apple-silicon.nixosModules.apple-silicon-support
      ./blub
      ./configuration.nix
    ];
  };

  blib = lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = {inherit inputs user;};
    modules = [
      apple-silicon.nixosModules.apple-silicon-support
      ./blib
      ./configuration.nix
    ];
  };

  agx = lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = {inherit inputs user;};
    modules = [
      jetpack-nixos.nixosModules.default
      ./agx
    ];
  };
}
