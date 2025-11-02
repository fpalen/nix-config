{ primaryUser, primaryMail, ... }:
{
  programs.git = {
    enable = true;
    userName = primaryUser; # TODO replace
    userEmail = "fpalen@gmail.com"; # TODO replace

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    extraConfig = {
      # github = {
        # user = primaryUser;
      # };
      url."ssh://git@github.com/".insteadOf = [
        "https://github.com/"
        "http://github.com/"
        "git://github.com/"
      ];
      init = {
        defaultBranch = "main";
      };
    };
  };
}
