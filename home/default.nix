{ primaryUser, primaryMail, ... }:
{
  imports = [
    ./packages.nix
    ./git.nix
    ./ssh.nix
    ./shell.nix
    ./mise.nix
    ./vscode.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
    };

    # create .hushlogin file to suppress login messages
    # file.".hushlogin".text = "";
  };
}
