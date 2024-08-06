{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "carrie";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Helsinki";

  services.openssh.enable = true;

  system.stateVersion = "24.05";
}
