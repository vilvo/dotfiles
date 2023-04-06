# SPDX-License-Identifier: MIT

{ pkgs, lib, user, ... }:

{
  imports = [ (import ./hardware-configuration.nix) ]
    ++ [ (import ./networking.nix) ];

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
  };
}
