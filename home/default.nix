{ primaryUser, primaryMail, ... }:
{
  imports = [
    ./packages.nix
    ./git.nix
    ./ssh.nix
    ./shell.nix
    ./mise.nix
    ./vscode.nix
    ./micorofto-edge.nix
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
