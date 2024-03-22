{
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "go-mode";
  src = fetchFromGitHub {
    owner = "dominikh";
    repo = "go-mode.el";
    rev = "6f4ff9e";
    hash = "sha256-fyBafjaiSOGTJoMnqwsF32JGo0xD2lDDQWQ2jJG8dt0=";
  };

  phases = ["installPhase"];

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
  '';
}
