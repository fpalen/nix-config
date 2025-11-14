{ primaryUser, primaryMail, ... }:
{
  imports = [
    ./fpalen/packages.nix
    ./fpalen/git.nix
    ./fpalen/ssh.nix
    ./fpalen/shell.nix
    ./fpalen/mise.nix
    ./fpalen/vscode.nix
    ./fpalen/globalprotect.nix
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
