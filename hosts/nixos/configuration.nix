# SPDX-License-Identifier: MIT
{ config, lib, pkgs, inputs, user, ... }:
{
  imports = [ ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.users."${user}" = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "dialout" "libvirtd" "wireshark" ];
    packages = with pkgs; [
      firefox
      google-chrome
      pulseaudio
      rustup
      emacs
      drawio
      micro
      calc
      rustup
    ];
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
      trusted-users = [ "root" "vilvo" ];
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
      builders-use-substitutes = true
    '';
    buildMachines = [ {
      hostName = "192.168.1.195";
      system = "aarch64-linux";
      maxJobs = 1;
      sshUser = "vilvo";
      supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
      sshKey = "/home/vilvo/.ssh/m1_nixos";
      publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIJbtUwpDSCLntv2ePOlwrpFeMkXSVrT76umd4rf5LGai";
    }];
    distributedBuilds = true;
  };
  # nix remote builders also require root accepted host key to avoid:
  # "Host key verification failed"
  # see https://github.com/NixOS/nix/issues/2030#issuecomment-1289522180
  # following is the output of: $ ssh-keyscan 192.168.1.174
  environment.etc."ssh/ssh_known_hosts".text = ''
  192.168.1.195 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1hZQT82XIfNiw2yaH1sFlko6ZWrrafLN5EPQ4g1ILNdoqvWcNdiUUEWCyST2t+ekLSpV05HWHD2vq7LsyWK7M6hfDLlQswFT5KSSKkia5DvlGwZCV1Z6HTgXmN+Pscj8grasZ5OnD+zCFVu9Tj3ReRSJyTEpipvsGBILPBVWke1X9tXcLORPeLKCGSrV4C85xT6Ufioheua/XzkpDaNNdCtj90NgmLd+JfWdoArN3CRAvODyero36f6z4ojIhiDGZUfKf2wR5GkMgRQkW/vyvNAsGbuAj08N4WbXoerYYZv+mdOPFwTzMikQ7f9Y44NZvmsvGxhPsbix7Qadc3dicBVpcFFYEysIk60mtJ7UdvtWX3FpPawCtTtUdJ3S/f5M3ugUw+hQZQi8okYaOhdZ1sthKMcmuxCK2zqHmWekJnC7wp7oLUp9cnTwprRKnzsD+U6Y1GE1Bmnd/hCduheL2eRe5hg6vpkv7vIsh7YtEA3l83+htQEF4YXkzU5poxqhxUR6i7e35QpmffLITzLXHDeCdC5TjtPOCplj6yWR/dzwTqoj1JWV5F2pSQxwK0uKYqCR9myVsMDPGzDeqysCSB5WF6oA9keEFW9vHN8x55FL+zWUpDXBYWn8mNNeNZ6LB0Wr+S2KIXt9uAp+OYCtcEYBQ8xbKkk84iNCRpMcgew==
  192.168.1.195 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbtUwpDSCLntv2ePOlwrpFeMkXSVrT76umd4rf5LGai
  '';
>>>>>>> 8761c3b (use eth interface static ip instead of wifi)

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
      git
      clang
    ];

  system.stateVersion = "22.11";
}
