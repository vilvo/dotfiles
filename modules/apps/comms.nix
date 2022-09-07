{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ thunderbird slack element-desktop signal-desktop ];
}
