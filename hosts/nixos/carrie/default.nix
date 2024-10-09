# SPDX-License-Identifier: MIT
{
  pkgs,
  user,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../profiles/bootloader.nix
    #../builders/known_host_nvidia_orin_agx.nix
    ../builders/known_host_apple-m1.nix
    ./packages.nix
    ./configuration.nix
  ];

  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  nix = {
    buildMachines = [
      #(import ../builders/local-nvidia-orin-agx.nix)
      #(import ../builders/local-apple-m1.nix)
    ];
  };

  environment.systemPackages = with pkgs; [linux-firmware alacritty uuu];
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
    ];
  };
}
