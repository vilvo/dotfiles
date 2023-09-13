{
  hostName = "192.168.1.195";
  system = "aarch64-linux";
  maxJobs = 1;
  sshUser = "vilvo";
  supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
  sshKey = "/home/vilvo/.ssh/m1_nixos";
  publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIJbtUwpDSCLntv2ePOlwrpFeMkXSVrT76umd4rf5LGai";
}
