{...}: {
  nix.settings.substituters = [
    "https://cache.vedenemo.dev"
  ];
  nix.settings.trusted-public-keys = [
    "cache.vedenemo.dev:RGHheQnb6rXGK5v9gexJZ8iWTPX6OcSeS56YeXYzOcg="
  ];
}
