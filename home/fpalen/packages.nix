{ pkgs, ... }:
{
  my.alacritty.enable = true;

  home = {
    packages = with pkgs; [
      # dev tools
      # curl
      # vim
      # tmux
      # htop
      # tree
      # ripgrep
      gh
      fastfetch
      # zoxide

      # programming languages
      # mise # node, deno, bun, rust, python, etc.

      # misc
      # nil
      # biome
      # nixfmt-rfc-style
      # yt-dlp
      # ffmpeg
      # ollama

      # fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];
  };
}
