# SPDX-License-Identifier: MIT
{
  pkgs,
  lib,
  user,
  ...
}: {
  imports = [(import ./hardware-configuration.nix)];

  networking.hostName = "mini";

  system.stateVersion = "24.05";
}
