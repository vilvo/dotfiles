# SPDX-License-Identifier: MIT
{
  pkgs,
  lib,
  user,
  ...
}: {
  imports = [(import ./hardware-configuration.nix)];
  nix = {
    buildMachines = [
      #{
      #  hostName = "192.168.1.195";
      #  system = "aarch64-linux";
      #  maxJobs = 1;
      #  sshUser = "vilvo";
      #  supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
      #  sshKey = "/home/vilvo/.ssh/m1_nixos";
      #  publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIJbtUwpDSCLntv2ePOlwrpFeMkXSVrT76umd4rf5LGai";
      #}
      {
        hostName = "192.168.1.149";
        system = "aarch64-linux";
        maxJobs = 4;
        sshUser = "vilvo";
        supportedFeatures = ["kvm" "benchmark" "big-parallel" "nixos-test"];
        sshKey = "/home/vilvo/.ssh/id_ed25519";
        publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIPK1VmVasHa7U86AEJZkIt8il0xI9CFZ4t+bClJyOYmv";
      }
      #      {
      #        hostName = "nixremote";
      #        system = "aarch64-linux";
      #        maxJobs = 4;
      #        sshUser = "vilvo";
      #        supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
      #        sshKey = "/home/vilvo/.ssh/id_ed25519_arm_cloud";
      #        publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIL3f7tAAO3Fc+8BqemsBQc/Yl/NmRfyhzr5SFOSKqrv0";
      #      }
    ];
  };

  # nix remote builders also require root accepted host key to avoid:
  # "Host key verification failed"
  # see https://github.com/NixOS/nix/issues/2030#issuecomment-1289522180
  # following is the output of: $ ssh-keyscan <host>
  environment.etc."ssh/ssh_known_hosts".text = ''
    192.168.1.195 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1hZQT82XIfNiw2yaH1sFlko6ZWrrafLN5EPQ4g1ILNdoqvWcNdiUUEWCyST2t+ekLSpV05HWHD2vq7LsyWK7M6hfDLlQswFT5KSSKkia5DvlGwZCV1Z6HTgXmN+Pscj8grasZ5OnD+zCFVu9Tj3ReRSJyTEpipvsGBILPBVWke1X9tXcLORPeLKCGSrV4C85xT6Ufioheua/XzkpDaNNdCtj90NgmLd+JfWdoArN3CRAvODyero36f6z4ojIhiDGZUfKf2wR5GkMgRQkW/vyvNAsGbuAj08N4WbXoerYYZv+mdOPFwTzMikQ7f9Y44NZvmsvGxhPsbix7Qadc3dicBVpcFFYEysIk60mtJ7UdvtWX3FpPawCtTtUdJ3S/f5M3ugUw+hQZQi8okYaOhdZ1sthKMcmuxCK2zqHmWekJnC7wp7oLUp9cnTwprRKnzsD+U6Y1GE1Bmnd/hCduheL2eRe5hg6vpkv7vIsh7YtEA3l83+htQEF4YXkzU5poxqhxUR6i7e35QpmffLITzLXHDeCdC5TjtPOCplj6yWR/dzwTqoj1JWV5F2pSQxwK0uKYqCR9myVsMDPGzDeqysCSB5WF6oA9keEFW9vHN8x55FL+zWUpDXBYWn8mNNeNZ6LB0Wr+S2KIXt9uAp+OYCtcEYBQ8xbKkk84iNCRpMcgew==
    192.168.1.195 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbtUwpDSCLntv2ePOlwrpFeMkXSVrT76umd4rf5LGai
    [awsarm.vedenemo.dev]:20220 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3f7tAAO3Fc+8BqemsBQc/Yl/NmRfyhzr5SFOSKqrv0
    [awsarm.vedenemo.dev]:20220 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtP5yuGAaMGK4GPsViPCIZvaPXN2tPoZH59i6CtPA1Vg8JzRX9g2PgFmUbNtQ9nxQhtUlVbNddCxoEKPJt+VgL/23o1DXM+EauuGOp9PijfcNqDq2jvwW1yoCnxMyA53vC7gR6CYGdu9BhQJYK9S4SaHtf4RcfUa39uWPfUCIKUyG9vB+T9p7E86O+pLBMRpAvppitFLdkxgAYZeedFUvhIQQZlTTJ7ELT3bJry5S+aBck83uZuU1guklyvCR9cZLMiAG2N4Goo/mH11kS4ytMV0AvpY2x4qY40wQvb3gGDYj53WArTkTf52yHELDbtCnjlwFW+5hJBog6CQaxy0S8eSN4MBbM2czmXh3sofwW7iB3iXr6q7IpTzcpeaiawau/OucTBnjVF+wm8C8MV3ekmEyTD+xEGQxESgJgqTLnHD3EKWm4qCTZBhq+XuazVP60eKvK5OVcIxsKHP4WO0YvP8oyjT62ur60wVKtJ2FJ3f0SAtSM2igV2KuDgdi3lek=
    [awsarm.vedenemo.dev]:20220 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNH+bPKgI9X7G1/MYq8fUSIkOyL2TmhH0quYlbX8fb9Z0AG6qRcNHaoFFIJaKxWEcAafo+hZNI1A9LKsY9MYXtE=
    [127.0.0.1]:21004 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMgbg/ApkYS2W2oM+CkFiCDnbHYGJAZGvtz6vcW28T1l
    [127.0.0.1]:21004 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJxr6B3RabL6gcfaTWl4s1LjJup61nXXH6GSrpM5aIkn3XR7zmbY6jfpgsQT+0tB/XNXFACzKB0utf4oEiC+j5gykh/37LB++vcg3eflm69AbvLD27NXfBuPk5R8uQ85F1PTKYcmoD/49BlEJl5qxPMb3SUADevQFULfDXz2MeaUzqhm7LfKPHYumFYaddTRNSvgAsAZLYcwoJKL9awzhTBWRdLD77GyyoFwOS69KMp/vKVQZtx4PJIINOVc6HVYIU4R/Dty4EQarGco/phByt/BTNCQbqa8eSu8cpAcU4lvNPsW0QXFMXD+ewE0ccwgs0HCjx0G1X7RikNnWnFFkh3/z9byZxIf8XHrqrY9YPCAlV5Iww4K3MoDxcdlHsjnHdAZAOT++6Z9bNJkFekrTfzSZRwyPB8Ad6LrIkYx4HS0f2SdKCIqaSVDDy8eat29nlMZnu3Mg4RUSEyMiOmvdsJH2249+TETzZIHuk64Wd0+w1IWRzZXBMDnRYvldl/xk=
    [127.0.0.1]:21004 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDXvdrdmu+8A04FF2pZLanbA6a4w0PjLGL7vrIIdI36WUNxxi2kGy3Pg9vllBY0a+CGRK99z1XlZCZ3FwithV/w=
    192.168.1.149 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJNQPXmfzavdOguKet5Tp4fC5DqmLy2WLHKf3bZThkNLV4zGvAL48en/iTeEq6j07JhOf5O41slJyT3ajJ5PzP1SvPBgmo9Sp51KpIGn8reySRxh9n970HSnLZ2PLviQXmjCcja6UUdkOC/kJ5fCZ208MT0nLfSyIdTuj8/U8E0l+X8omh02Plc25XMUTwusGMc8UHj2pzzixz2Jo07+nmu/my7mdCMBGXr7/+g/0/MVW6EdoHtbivVonJcn6q77beEuUiw/siUtafu0wcyoF0kIQ4y3jvaWLykwJoCPpvYz0gutaA+5GvH5TgU8ssKMClZvRbUEnD2gcWNYdSPieqIyo9ehvM9jMzIY8pQ+kjQH0ZA56WULX1Bp1z9T0yqqbNvsfg/irSfnhzBn4KgoRLJPd+G5r2pxVdHjaX12x2wDrjbpvKbB7+AzbqeeAt0TEJcvEaooTvua6U0k7sMr4MGj628eTyoO5ZgGqLVYLP7esK1/VYNJt4L9y2tBJgJ85+lMwqctQXdrfa4KxfqypR9rJ2erAhwj+pUqYuIxar+3wynddp/vhH6YYks//N/2QWYe+pDv+NWfiXsV3zIL1F2L/lRuCGIsdpv5OcrOTbDOYaZyq3sek0ymwUDOCt9vwU1i57X8qoq9DozOgn9YmmC7Z4ZvZ4q4uCPB/w6vD8sw==
    192.168.1.149 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPK1VmVasHa7U86AEJZkIt8il0xI9CFZ4t+bClJyOYmv
  '';
  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
  };
}
