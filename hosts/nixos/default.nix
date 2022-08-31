# SPDX-License-Identifier: MIT

{ lib, inputs, nixpkgs, home-manager, user, ... }:

let
  system = "x86_64-linux";

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
    specialArgs = { inherit inputs user; };
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
