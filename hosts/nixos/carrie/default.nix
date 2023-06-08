# SPDX-License-Identifier: MIT

{ pkgs, lib, user, ... }:

{
  imports = [ (import ./hardware-configuration.nix) ];

  environment.systemPackages = with pkgs; [ linux-firmware alacritty ];
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAS51BVp5fecNMh2zm72H3j8qtzW3JnWYxaw/ejQOvnX vilvo@blip"
    ];
  };

  system.stateVersion = "23.05";

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
  };
}
