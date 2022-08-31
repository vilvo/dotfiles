{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
  ];

  programs = {
    bat.enable = true;
    htop.enable = true;
    starship.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    bash.enable = true;
  };
}
