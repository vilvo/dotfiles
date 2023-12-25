# SPDX-License-Identifier: MIT
{
  config,
  lib,
  pkgs,
  inputs,
  user,
  ...
}: let
  swayconfig = pkgs.callPackage ./profiles/sway.nix {};
  emacsconfig = pkgs.callPackage ./profiles/emacs.nix {};
  rust-mode = pkgs.callPackage ./pkgs/rust-mode/default.nix {};
in {
  imports = [
    ./aliases.nix
    ../../modules/networking/blocked_hosts.nix
  ];

  system.userActivationScripts.linkconfigs.text = ''
    mkdir -p "$HOME/.config/sway/"
    ln -fs ${swayconfig}/config "$HOME/.config/sway/config"
    ln -fs ${swayconfig}/status.sh "$HOME/.config/sway/status.sh"

    ln -fs ${emacsconfig}/.emacs "$HOME/.emacs"
    ln -fs ${rust-mode}/ "$HOME/rust-mode"
  '';

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.users."${user}" = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = ["networkmanager" "wheel" "dialout" "libvirtd" "wireshark"];
    packages = with pkgs; [
      firefox
      pulseaudio
      drawio
      micro
      calc
      screen
      pciutils
      graphviz
      vscode
      emacs
      rustup
      tree
      htop
      nix-tree
      direnv
      usbutils
      eza
      starship
    ];
  };

  services.emacs.enable = true;
  services.openssh.enable = true;
  services.adguardhome.enable = true;

  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  programs.wireshark.enable = true;

  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;
  programs.xwayland.enable = true;

  # nmcli device wifi connect <SSID> password <password>
  networking = {
    networkmanager = {
      enable = true;
      # for adguardhome
      insertNameservers = [ "127.0.0.1" ];
    };
  };

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      alacritty
      bemenu
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
  };

  nix = {
    settings = {
      trusted-users = ["root" "vilvo"];
      auto-optimise-store = true;
    };
    gc = {
      # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
    '';
    distributedBuilds = true;
  };
  # nix remote builders also require root accepted host key to avoid:
  # "Host key verification failed"
  # see https://github.com/NixOS/nix/issues/2030#issuecomment-1289522180
  # following is the output of: $ ssh-keyscan <host>
  environment.etc."ssh/ssh_known_hosts".text = ''
    [awsarm.vedenemo.dev]:20220 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3f7tAAO3Fc+8BqemsBQc/Yl/NmRfyhzr5SFOSKqrv0
    [awsarm.vedenemo.dev]:20220 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtP5yuGAaMGK4GPsViPCIZvaPXN2tPoZH59i6CtPA1Vg8JzRX9g2PgFmUbNtQ9nxQhtUlVbNddCxoEKPJt+VgL/23o1DXM+EauuGOp9PijfcNqDq2jvwW1yoCnxMyA53vC7gR6CYGdu9BhQJYK9S4SaHtf4RcfUa39uWPfUCIKUyG9vB+T9p7E86O+pLBMRpAvppitFLdkxgAYZeedFUvhIQQZlTTJ7ELT3bJry5S+aBck83uZuU1guklyvCR9cZLMiAG2N4Goo/mH11kS4ytMV0AvpY2x4qY40wQvb3gGDYj53WArTkTf52yHELDbtCnjlwFW+5hJBog6CQaxy0S8eSN4MBbM2czmXh3sofwW7iB3iXr6q7IpTzcpeaiawau/OucTBnjVF+wm8C8MV3ekmEyTD+xEGQxESgJgqTLnHD3EKWm4qCTZBhq+XuazVP60eKvK5OVcIxsKHP4WO0YvP8oyjT62ur60wVKtJ2FJ3f0SAtSM2igV2KuDgdi3lek=
    [awsarm.vedenemo.dev]:20220 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNH+bPKgI9X7G1/MYq8fUSIkOyL2TmhH0quYlbX8fb9Z0AG6qRcNHaoFFIJaKxWEcAafo+hZNI1A9LKsY9MYXtE=
  '';

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    clang
    alejandra
  ];
}
