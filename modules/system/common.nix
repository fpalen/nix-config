{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    rsync
    htop
    wget
    curl
    bash
    tmux
  ];

  # Opcional: variables globales del entorno
  # environment.variables = {
  #   PAGER = "less";
  #   EDITOR = "nvim";
  # };
}
