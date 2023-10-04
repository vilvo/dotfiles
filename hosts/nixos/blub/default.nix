# SPDX-License-Identifier: MIT
{
  pkgs,
  lib,
  user,
  ...
}: {
  imports = [(import ./hardware-configuration.nix)];

  networking.hostName = "blub";

  system.stateVersion = "23.05";
}
