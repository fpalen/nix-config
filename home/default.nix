{ primaryUser, primaryMail, ... }:
{
  imports = [
    lazyvim.homeManagerModules.default
    ./packages.nix
    ./git.nix
    ./ssh.nix
    ./shell.nix
    ./mise.nix
    ./vscode.nix
    ./globalprotect.nix
    ./neovim.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
      GH_TOKEN="$(op read 'op://Personal/GitHub/TOKEN')";
    };

    # create .hushlogin file to suppress login messages
    # file.".hushlogin".text = "";
  };
}
