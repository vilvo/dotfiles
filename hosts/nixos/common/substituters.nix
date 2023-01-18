{ ... }:

{
  nix.settings.substituters = [
    "https://cache.vedenemo.dev"
    "https://cache.nixos.org/"
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "cache.vedenemo.dev:RGHheQnb6rXGK5v9gexJZ8iWTPX6OcSeS56YeXYzOcg="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "awsarm.vedenemo.dev:OsgX+Jqb3w8dpodJIznsi0ByQIyk3opYbPvRERNduCo="
  ];
}
