 {config, lib, pkgs, ... }:

{
  nix.buildMachines = [
    {
      hostName = "awsarm";
      system = "aarch64-linux";
      maxJobs = 16;
      speedFactor = 2;
      supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
      mandatoryFeatures = [];
      publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIL3f7tAAO3Fc+8BqemsBQc/Yl/NmRfyhzr5SFOSKqrv0";
    }
  ];
  nix.distributedBuilds = true;
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
