{stdenvNoCC,fetchFromGitHub,...}:
stdenvNoCC.mkDerivation {
  name = "rust-mode";
  src = fetchFromGitHub {
    owner = "rust-lang";
    repo = "rust-mode";
    rev = "9c26dc1195ec05309ee15c014631fb9abd6cf5d2";
    hash = "sha256-r888RkK1ec5Uzi1wB1dyszZThF23stQ/u08KnB4KrdI=";
  };

  phases = ["installPhase"];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
  '';
}
