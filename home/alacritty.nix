{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux  = pkgs.stdenv.isLinux;

  # Tamaño de fuente distinto según plataforma
  fontSize =
    if isDarwin then 14.0 else 12.0;
in
{
  options.my.alacritty.enable =
    lib.mkEnableOption "Enable Alacritty with a shared, cross-platform config";

  config = lib.mkIf config.my.alacritty.enable {

    # Home Manager ya trae el módulo de Alacritty
    programs.alacritty = {
      enable = true;
      package = pkgs.alacritty;

      # Config común en formato Nix -> se convierte en TOML/YAML según versión
      settings = {
        window = {
          padding = { x = 8; y = 8; };
          dynamic_padding = true;
          decorations = "full";
          opacity = 1.0; # sin transparencia para que sea estable en todos los SO
        };

        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style  = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font";
            style  = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style  = "Italic";
          };
          size = fontSize;
        };

        cursor = {
          style = { shape = "Block"; blinking = "On"; };
          unfocused_hollow = true;
        };

        # Variables de entorno comunes
        env = {
          TERM = "xterm-256color";
        } // lib.optionalAttrs isLinux {
          # Cosillas útiles para Linux/WSL; ajusta si quieres Wayland
          WINIT_UNIX_BACKEND = "x11";
        };
      };
    };
  };
}