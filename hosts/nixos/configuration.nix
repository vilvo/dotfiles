# SPDX-License-Identifier: MIT
{ config, lib, pkgs, inputs, user, ... }:

{
  imports =
    [
      # for all machines tbd
    ];

  users.users."${user}" = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ firefox google-chrome ];
  };

  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "fi";
    xkbVariant = "nodeadkeys";
  };

  console.keyMap = "fi";
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = { # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
      git
    ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
