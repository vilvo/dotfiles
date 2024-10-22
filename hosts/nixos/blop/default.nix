# SPDX-License-Identifier: MIT
{
  pkgs,
  lib,
  user,
  ...
}: {
  imports = [(import ./hardware-configuration.nix)];

  environment.systemPackages = with pkgs; [linux-firmware alacritty];
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  networking.interfaces.eth0.useDHCP = true;
  networking.hostName = "blop";

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.opengl.enable = true;

  services.avahi.enable = true;

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAS51BVp5fecNMh2zm72H3j8qtzW3JnWYxaw/ejQOvnX vilvo@blip"
    ];
    packages = with pkgs; [
      google-chrome
      slack
      signal-desktop
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
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
