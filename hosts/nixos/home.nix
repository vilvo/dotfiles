{ config, lib, pkgs, user, ... }:

{
  imports = (import ../../modules/shell) ++ (import ../../modules/apps);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "22.11";
  };

  programs = { home-manager.enable = true; };
}
