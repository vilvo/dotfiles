{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    element-desktop
    slack
    thunderbird
  ];
}
