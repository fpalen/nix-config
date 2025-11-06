{ pkgs, ... }:

{
  xdg.desktopEntries.discord = {
      name = "Discord";
      exec = pkgs.brave " --app=https://discord.com/app";
  };
}
