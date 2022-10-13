
{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    screen
  ];

  programs = {
    bat.enable = true;
    htop.enable = true;
    starship.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    bash.enable = true;
  };
}
