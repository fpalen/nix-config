{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # Configuración de perfiles
    profiles.default = {
      # Declaración de extensiones
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [

      ];

      # Opcional: preferencias de usuario
      prefs = {

      };
    };
  };
}
