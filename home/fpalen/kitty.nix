{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };

    settings = {
      # Nord palette
      background = "#2E3440"; # nord0
      foreground = "#D8DEE9"; # nord4

      selection_background = "#4C566A"; # nord3
      selection_foreground = "#ECEFF4"; # nord6

      cursor = "#D8DEE9";          # nord4
      cursor_text_color = "#2E3440"; # nord0

      url_color = "#88C0D0"; # nord8

      active_tab_background   = "#4C566A"; # nord3
      active_tab_foreground   = "#ECEFF4"; # nord6
      inactive_tab_background = "#3B4252"; # nord1
      inactive_tab_foreground = "#D8DEE9"; # nord4
      tab_bar_background      = "#2E3440"; # nord0

      # Colors 0–15
      color0  = "#3B4252"; # nord1
      color1  = "#BF616A"; # nord11
      color2  = "#A3BE8C"; # nord14
      color3  = "#EBCB8B"; # nord13
      color4  = "#81A1C1"; # nord9
      color5  = "#B48EAD"; # nord15
      color6  = "#88C0D0"; # nord8
      color7  = "#E5E9F0"; # nord5
      color8  = "#4C566A"; # nord3
      color9  = "#BF616A"; # nord11
      color10 = "#A3BE8C"; # nord14
      color11 = "#EBCB8B"; # nord13
      color12 = "#81A1C1"; # nord9
      color13 = "#B48EAD"; # nord15
      color14 = "#8FBCBB"; # nord7
      color15 = "#ECEFF4"; # nord6
    };
  };
}