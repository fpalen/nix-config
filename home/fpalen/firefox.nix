{ pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;

    # Configuración de perfiles
    profiles.default = {
      # Declaración de extensiones
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
      ];

      # Opcional: preferencias de usuario
      prefs = {

      };
    };
  };
}
