_: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      fastfetch
    '';

    shellAliases = {
      "la" = "ls -la";
      ".." = "cd ..";
      "g" = "git";
      "nix-switch" = "sudo darwin-rebuild switch --flake ~/.config/nix#my-macbook";
      "nixup" = "nix-switch";
      "gp-start" = "global start";
      "gp-stop" = "global stop";
    };
  };

  # programs.starship = {
  # enable = true;
  # settings = {
  # add_newline = false;
  # character = {
  # success_symbol = "[λ](bold green)";
  # error_symbol = "[λ](bold red)";
  # };
  # };
  # };
}
