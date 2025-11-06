{ pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim;
  };

  programs.lazygit.enable = true;

  home.packages = with pkgs; [ git ripgrep fd wget unzip ];

  # Trae el starter de LazyVim a ~/.config/nvim de forma declarativa
  xdg.configFile."nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "LazyVim";
      repo  = "starter";
      rev   = "main";        # cuando quieras, fija a un commit concreto
      sha256 = lib.fakeSha256;  # primer build te dirá el hash correcto
    };
    recursive = true;
  };

  home.sessionVariables.EDITOR = "nvim";
}
