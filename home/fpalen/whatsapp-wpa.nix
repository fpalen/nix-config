{ config, pkgs, ... }:

let
  homeDir = config.home.homeDirectory;  # normalmente /Users/fpalen
in {
  # Política de sandbox de macOS para WhatsApp
  home.file.".sandbox/policies/whatsapp.sb".text = ''
    (version 1)

    ;; Denegamos todo por defecto
    (deny default)

    ;; Permitir que el proceso exista y lance hijos
    (allow process*)

    ;; Permitir red (imprescindible para una webapp)
    (allow network*)

    ;; Permitir lectura de partes básicas del sistema
    (allow file-read*
      (subpath "/System")
      (subpath "/usr")
      (subpath "/Library")
      (subpath "/Applications")
    )

    ;; Solo puede leer y escribir en su propio perfil de sandbox
    (allow file-read* (subpath "${homeDir}/.sandbox/whatsapp"))
    (allow file-write* (subpath "${homeDir}/.sandbox/whatsapp"))

    ;; Opcional: acceso a fuentes de usuario
    (allow file-read* (subpath "${homeDir}/Library/Fonts"))
  '';

  # Script de lanzamiento: ~/bin/whatsapp-sandbox
  home.file."bin/whatsapp-sandbox" = {
    text = ''
      #!/usr/bin/env bash

      SANDBOX_DIR="${homeDir}/.sandbox/whatsapp"
      POLICY="${homeDir}/.sandbox/policies/whatsapp.sb"
      CHROMIUM="/Applications/Chromium.app/Contents/MacOS/Chromium"

      mkdir -p "$SANDBOX_DIR"

      exec sandbox-exec -f "$POLICY" \
        "$CHROMIUM" \
        --user-data-dir="$SANDBOX_DIR" \
        --app="https://web.whatsapp.com" \
        --no-first-run \
        --no-default-browser-check \
        --disable-sync \
        --disable-extensions \
        --disable-gpu
    '';
    executable = true;
  };
}