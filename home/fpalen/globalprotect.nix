{ config, pkgs, ... }:

let
  scriptsDir = ./.;
in {
  home.file.".local/bin/global".source = "${scriptsDir}/scripts/global.sh";
  # home.file.".local/bin/gp-stop".source = "${scriptsDir}/scripts/gp-stop.sh";
  # home.file.".local/bin/gp-restart".source = "${scriptsDir}/scripts/gp-restart.sh";
  # home.file.".local/bin/gp-start".source = "${scriptsDir}/scripts/gp-start.sh";
}
