# SPDX-License-Identifier: MIT
{
  pkgs,
  user,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
