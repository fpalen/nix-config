{ primaryUser, primaryMail, pkgs, lib, inputs, ... }:
{
  imports = [
    ./fpalen/firefox.nix
    ./fpalen/git.nix
    ./fpalen/globalprotect.nix
    ./fpalen/mise.nix
    ./fpalen/packages.nix
    ./fpalen/shell.nix
    ./fpalen/ssh.nix
    ./fpalen/vscode.nix
    ./fpalen/whatsapp-wpa.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      # shared environment variables
      NH_FLAKE = "$HOME/.config/nix";
      GH_TOKEN="$(op read 'op://Personal/GitHub/TOKEN')";
    };

    # create .hushlogin file to suppress login messages
    # file.".hushlogin".text = "";
  };
}
