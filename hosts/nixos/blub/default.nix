# SPDX-License-Identifier: MIT
{
  pkgs,
  lib,
  user,
  ...
}: {
  imports = [(import ./hardware-configuration.nix)];
  system.stateVersion = "23.05";
}
