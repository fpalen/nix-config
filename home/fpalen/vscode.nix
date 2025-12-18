{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      shd101wyy.markdown-preview-enhanced
    ];
    keybindings = [
      {
        key = "cmd+alt+p";
        command = "git.push";
        when = "gitOpenRepositoryCount != 0";
      }
    ];
  };
}
