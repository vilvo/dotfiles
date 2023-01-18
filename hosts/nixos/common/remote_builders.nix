{ user, awsarmkey, ... }:

let
  inherit user awsarmkey;
in
{
  nix.buildMachines = [
    {
      hostName = "awsarm.vedenemo.dev";
      system = "aarch64-linux";
      maxJobs = 16;
      speedFactor = 2;
      supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
      mandatoryFeatures = [];
      sshUser = "${user}";
      sshKey = "${awsarmkey}";
      publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIL3f7tAAO3Fc+8BqemsBQc/Yl/NmRfyhzr5SFOSKqrv0";
    }
  ];
  nix.distributedBuilds = true;
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
  environment.etc."ssh/ssh_known_hosts".text = ''
    [awsarm.vedenemo.dev]:20220 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3f7tAAO3Fc+8BqemsBQc/Yl/NmRfyhzr5SFOSKqrv0
    [awsarm.vedenemo.dev]:20220 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtP5yuGAaMGK4GPsViPCIZvaPXN2tPoZH59i6CtPA1Vg8JzRX9g2PgFmUbNtQ9nxQhtUlVbNddCxoEKPJt+VgL/23o1DXM+EauuGOp9PijfcNqDq2jvwW1yoCnxMyA53vC7gR6CYGdu9BhQJYK9S4SaHtf4RcfUa39uWPfUCIKUyG9vB+T9p7E86O+pLBMRpAvppitFLdkxgAYZeedFUvhIQQZlTTJ7ELT3bJry5S+aBck83uZuU1guklyvCR9cZLMiAG2N4Goo/mH11kS4ytMV0AvpY2x4qY40wQvb3gGDYj53WArTkTf52yHELDbtCnjlwFW+5hJBog6CQaxy0S8eSN4MBbM2czmXh3sofwW7iB3iXr6q7IpTzcpeaiawau/OucTBnjVF+wm8C8MV3ekmEyTD+xEGQxESgJgqTLnHD3EKWm4qCTZBhq+XuazVP60eKvK5OVcIxsKHP4WO0YvP8oyjT62ur60wVKtJ2FJ3f0SAtSM2igV2KuDgdi3lek=
   [awsarm.vedenemo.dev]:20220 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNH+bPKgI9X7G1/MYq8fUSIkOyL2TmhH0quYlbX8fb9Z0AG6qRcNHaoFFIJaKxWEcAafo+hZNI1A9LKsY9MYXtE=
  '';
  programs.ssh.extraConfig = ''
    Host awsarm awsarm.vedenemo.dev
        Hostname awsarm.vedenemo.dev
        user "${user}"
        Port 20220
    '';
}
