{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [virt-manager crosvm libvirt qemu_kvm];
}
