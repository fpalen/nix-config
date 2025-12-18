{ primaryUser, primaryMail, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = primaryUser;
        email = primaryMail;
      };
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

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    # extraConfig = {
    # };
  };
}
