# SPDX-License-Identifier: MIT

{ lib, inputs, nixpkgs, home-manager, user, ... }:

let
  system = "x86_64-linux";

  # ssh private key path for remote builds
  # arg to generic common/remote_builders.nix module
  # TODO: learn yubikeys with nixos
  awsarmkey = "/home/${user}/.ssh/id_ed25519_arm_cloud";

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

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          programs.bash.enable = true;
          imports = [ (import ./home.nix) ] ++ [ (import ./blop/home.nix) ];
        };
      }
    ];
  };

  blip = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user awsarmkey; };
    modules = [
      ./blip
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          programs.bash.enable = true;
          imports = [ (import ./home.nix) ] ++ [ (import ./blip/home.nix) ];
        };
      }
    ];
  };
}
