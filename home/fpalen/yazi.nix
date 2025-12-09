{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;

    # Integra Yazi con zsh y crea el wrapper `y`
    enableZshIntegration = true;
    shellWrapperName = "y";

    # Herramientas que Yazi usará para búsquedas y previews
    extraPackages = with pkgs; [
      fd
      ripgrep
      fzf
      jq
      poppler              # PDFs
      ffmpegthumbnailer    # thumbnails de vídeo
      imagemagick          # imágenes
      zoxide
      bat
    ];

    # Config básica de layout / preview
    settings = {
      manager = {
        show_hidden    = true;
        sort_by        = "natural";
        sort_sensitive = true;
        sort_reverse   = false;
        sort_dir_first = true;
        linemode       = "size";
        ratio          = [ 1 4 3 ];
      };

      preview = {
        max_width     = 600;
        max_height    = 900;
        tab_size      = 2;
        image_filter  = "lanczos3";
        image_quality = 90;
      };
    };

    # 🎨 Tema Nord para Yazi
    theme = {
      ui = {
        background = "#2E3440"; # nord0

        panel = {
          normal = { fg = "#D8DEE9"; bg = "#2E3440"; }; # nord4/nord0
          active = { fg = "#ECEFF4"; bg = "#3B4252"; }; # nord6/nord1
          border = "#4C566A";                            # nord3
          title  = "#88C0D0";                            # nord8
        };

        cursor = {
          normal = { fg = "#2E3440"; bg = "#88C0D0"; }; # nord0/nord8
          select = { fg = "#2E3440"; bg = "#8FBCBB"; }; # nord0/nord7
        };

        status = {
          normal  = { fg = "#E5E9F0"; bg = "#3B4252"; }; # nord5/nord1
          primary = { fg = "#88C0D0"; bg = "#3B4252"; };
          info    = { fg = "#81A1C1"; bg = "#3B4252"; };
        };

        selection = {
          fg = "#2E3440";
          bg = "#8FBCBB"; # nord7
        };
      };

      filetype = {
        rules = [
          { fg = "#81A1C1"; mime = "text/*"; }              # nord9
          { fg = "#8FBCBB"; mime = "image/*"; }             # nord7
          { fg = "#EBCB8B"; mime = "video/*"; }             # nord13
          { fg = "#D08770"; mime = "audio/*"; }             # nord12
          { fg = "#B48EAD"; mime = "application/zip"; }     # nord15
          { fg = "#BF616A"; mime = "application/x-bzip"; }  # nord11
        ];
      };
    };
  };
}