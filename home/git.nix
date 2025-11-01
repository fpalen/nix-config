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
      init = {
        defaultBranch = "main";
      };
    };
  };
}
