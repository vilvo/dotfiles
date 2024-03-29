# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  networking.hostName = "carrie";
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../profiles/bootloader.nix
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-intel"];
  boot.kernelParams = ["i915.force_probe=9a60"];
  boot.extraModulePackages = [];

  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9d99ad26-3dc6-4261-916e-a715cdf3a0e6";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/197c1e4f-baf8-4038-9705-c9b4ac9096c0";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3416-D06E";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 10000;
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp11s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp9s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
