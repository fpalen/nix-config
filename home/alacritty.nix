{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (pkgs.stdenv) isDarwin;
  inherit (pkgs.stdenv) isLinux;

  fontSize = if isDarwin then 14.0 else 12.0;
in
{
  options.my.alacritty.enable = lib.mkEnableOption "Enable Alacritty with a shared, cross-platform config";

  config = lib.mkIf config.my.alacritty.enable {
    programs.alacritty = {
      enable = true;
      package = pkgs.alacritty;

      settings = {
        window = {
          startup_mode = "Fullscreen";
          padding = {
            x = 8;
            y = 8;
          };
          dynamic_padding = true;
          decorations = "full";
          opacity = 1.0;
        };

        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Italic";
          };
          size = fontSize;

          # ❌ Nada de `features` aquí: Alacritty no lo soporta
        };

        cursor = {
          style = {
            shape = "Block";
            blinking = "On";
          };
          unfocused_hollow = true;
        };

        env = {
          TERM = "xterm-256color";
        }
        // lib.optionalAttrs isLinux {
          WINIT_UNIX_BACKEND = "x11";
        };
      };
    };
  };
}
