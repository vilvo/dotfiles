{ config, lib, pkgs, user, ... }:

{
  imports = (import ../../modules/shell);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "22.11";
  };

  programs = { home-manager.enable = true; };
}
