{ primaryUser, primaryMail, ... }:
{
  programs.git = {
    enable = true;
    userName = primaryUser;
    userEmail = primaryMail;

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    extraConfig = {
      color.ui = "auto";

      alias = {
        s = "status -sb --ignore-submodules=dirty";
        st = "status";
      };
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
