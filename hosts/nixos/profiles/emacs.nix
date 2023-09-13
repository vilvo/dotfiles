{ stdenvNoCC, lib, }:
  stdenvNoCC.mkDerivation {
    name = "custom-emacs-config";

    src = ./emacs;

    phases = [ "installPhase" ];

    installPhase = ''
      mkdir -p $out
      cp $src/.emacs $out
    '';

    meta = with lib; {
      description = "vilvo's emacs config";
      platforms = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
