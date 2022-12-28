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
    extraGroups = [ "networkmanager" "wheel" "dialout" "libvirtd" "wireshark" ];
    packages = with pkgs; [ firefox google-chrome pulseaudio rustup emacs ];
  };

  services.emacs.enable = true;

  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  programs.wireshark.enable = true;

  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;

  # nmcli device wifi connect <SSID> password <password>
  networking.networkmanager.enable = true;

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      alacritty
      dmenu
      slurp
      grim
    ];
    wrapperFeatures.gtk = true;
  };

  console.keyMap = "fi";
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = { # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
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

  nix.settings.substituters = [
    "http://binarycache.vedenemo.dev"
    "https://cache.dataaturservice.se/spectrum/"
    "https://cache.nixos.org/"
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "binarycache.vedenemo.dev:Yclq5TKpx2vK7WVugbdP0jpln0/dPHrbUYfsH3UXIps="
    "spectrum-os.org-1:rnnSumz3+Dbs5uewPlwZSTP0k3g/5SRG4hD7Wbr9YuQ="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

}
