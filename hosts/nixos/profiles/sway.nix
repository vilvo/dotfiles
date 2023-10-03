{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  name = "custom-sway-config";

  src = ./sway;

  phases = ["installPhase"];

  installPhase = ''
    mkdir -p $out
    cp $src/config $out
    cp $src/status.sh $out
  '';

  meta = with lib; {
    description = "vilvo's sway config and status bar update";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
