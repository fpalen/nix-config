{ pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;

    # Configuración de perfiles
    profiles.default = {
      # Declaración de extensiones
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
      ];

      # Opcional: preferencias de usuario
      settings = {
        "browser.shell.checkDefaultBrowser" = false;
        "browser.translations.automaticallyPopup" = false;
        "browser.translations.enable" = false;
      };
    };
  };
}
