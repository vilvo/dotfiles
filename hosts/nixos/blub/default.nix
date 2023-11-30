# SPDX-License-Identifier: MIT
{
  pkgs,
  lib,
  user,
  ...
}: {
  imports = [(import ./hardware-configuration.nix)];

  networking.hostName = "blub";

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwRelxFwR6WPBm86b52q7pjQd8mEiqj1R3yj6YVL6wM vilvo@blip"
    ];
  };

  system.stateVersion = "23.05";
}
