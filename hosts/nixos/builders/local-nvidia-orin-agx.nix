{
  hostName = "192.168.1.149";
  system = "aarch64-linux";
  maxJobs = 4;
  sshUser = "vilvo";
  supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
  sshKey = "/home/vilvo/.ssh/id_ed25519";
  publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIPK1VmVasHa7U86AEJZkIt8il0xI9CFZ4t+bClJyOYmv";
}
