 {config, lib, pkgs, ... }:

{
  networking.interfaces.eth0.useDHCP = true;
  networking.hostName = "blip";
}
