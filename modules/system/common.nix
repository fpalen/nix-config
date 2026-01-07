{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    rsync
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
