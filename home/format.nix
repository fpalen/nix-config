{ config, pkgs, lib, ... }:

let
  # donde vive tu flake de configuración
  flakeDir = "${config.home.homeDirectory}/.config/nix";
in
{
  home.activation.formatNix =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -d "${flakeDir}" ]; then
        echo "↻ Formateando Nix con treefmt..."
        cd "${flakeDir}"

        # Ejecuta el formatter del flake para este sistema
        nix run .#formatter.${pkgs.stdenv.hostPlatform.system} || true
      else
        echo "↻ formatNix: ${flakeDir} no existe, saltando"
      fi
    '';
}