{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    rsync # GNU rsync (idéntico en Linux y macOS)
    htop
    wget
    curl
    bash
  ];

  # Opcional: variables globales del entorno
  # environment.variables = {
  #   PAGER = "less";
  #   EDITOR = "nvim";
  # };
}
