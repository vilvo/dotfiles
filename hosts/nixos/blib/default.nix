# SPDX-License-Identifier: MIT
{
  pkgs,
  lib,
  user,
  ...
}: {
  imports = [(import ./hardware-configuration.nix)];

  networking.hostName = "blib";

  system.stateVersion = "23.11";
}
