# SPDX-License-Identifier: MIT
{
  pkgs,
  user,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../profiles/bootloader.nix
    ../builders/known_host_nvidia_orin_agx.nix
    ../builders/known_host_apple-m1.nix
  ];

  nix = {
    buildMachines = [
      #(import ../builders/local-nvidia-orin-agx.nix)
      (import ../builders/local-apple-m1.nix)
    ];
  };

  environment.systemPackages = with pkgs; [linux-firmware alacritty];
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAS51BVp5fecNMh2zm72H3j8qtzW3JnWYxaw/ejQOvnX vilvo@blip"
    ];
  };

  system.stateVersion = "23.05";
}
