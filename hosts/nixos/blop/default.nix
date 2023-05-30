# SPDX-License-Identifier: MIT

{ pkgs, lib, user, ... }:

{
  imports = [ (import ./hardware-configuration.nix) ]
    ++ [ (import ./networking.nix) ];

  environment.systemPackages = with pkgs; [ linux-firmware alacritty ];
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAS51BVp5fecNMh2zm72H3j8qtzW3JnWYxaw/ejQOvnX vilvo@blip"
    ];
  };

  nix = {
    buildMachines = [
    {
      hostName = "172.18.8.200";
      system = "aarch64-linux";
      maxJobs = 1;
      sshUser = "vilvo";
      supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
      sshKey = "/home/vilvo/.ssh/m1_nixos";
      publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIJbtUwpDSCLntv2ePOlwrpFeMkXSVrT76umd4rf5LGai";
    }
    ];
  };

  # nix remote builders also require root accepted host key to avoid:
  # "Host key verification failed"
  # see https://github.com/NixOS/nix/issues/2030#issuecomment-1289522180
  # following is the output of: $ ssh-keyscan 192.168.1.174
  environment.etc."ssh/ssh_known_hosts".text = ''
    172.18.8.200 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1hZQT82XIfNiw2yaH1sFlko6ZWrrafLN5EPQ4g1ILNdoqvWcNdiUUEWCyST2t+ekLSpV05HWHD2vq7LsyWK7M6hfDLlQswFT5KSSKkia5DvlGwZCV1Z6HTgXmN+Pscj8grasZ5OnD+zCFVu9Tj3ReRSJyTEpipvsGBILPBVWke1X9tXcLORPeLKCGSrV4C85xT6Ufioheua/XzkpDaNNdCtj90NgmLd+JfWdoArN3CRAvODyero36f6z4ojIhiDGZUfKf2wR5GkMgRQkW/vyvNAsGbuAj08N4WbXoerYYZv+mdOPFwTzMikQ7f9Y44NZvmsvGxhPsbix7Qadc3dicBVpcFFYEysIk60mtJ7UdvtWX3FpPawCtTtUdJ3S/f5M3ugUw+hQZQi8okYaOhdZ1sthKMcmuxCK2zqHmWekJnC7wp7oLUp9cnTwprRKnzsD+U6Y1GE1Bmnd/hCduheL2eRe5hg6vpkv7vIsh7YtEA3l83+htQEF4YXkzU5poxqhxUR6i7e35QpmffLITzLXHDeCdC5TjtPOCplj6yWR/dzwTqoj1JWV5F2pSQxwK0uKYqCR9myVsMDPGzDeqysCSB5WF6oA9keEFW9vHN8x55FL+zWUpDXBYWn8mNNeNZ6LB0Wr+S2KIXt9uAp+OYCtcEYBQ8xbKkk84iNCRpMcgew==
    172.18.8.200 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbtUwpDSCLntv2ePOlwrpFeMkXSVrT76umd4rf5LGai
    '';

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
