# SPDX-License-Identifier: MIT

{ pkgs, lib, user, ... }:

{
  imports = [ (import ./hardware-configuration.nix) ]
    ++ [ (import ./networking.nix) ];

  services.xserver.videoDrivers = [ "nouveau" ];
  hardware.opengl.enable = true;

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAS51BVp5fecNMh2zm72H3j8qtzW3JnWYxaw/ejQOvnX vilvo@blip"
    ];
  };

  services.openssh.enable = true;

  system.stateVersion = "22.11";

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
  };
}
