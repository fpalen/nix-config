_: {
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    # homebrew is best for GUI apps
    # nixpkgs is best for CLI tools
    casks = [
      # OS enhancements
      # "aerospace"
      # "cleanshot"
      # "hiddenbar"
      # "raycast"
      # "betterdisplay"

      # browsers
      "firefox"
      "microsoft-edge"
      "brave-browser"
      "chromium"

      # dev
      # "cursor"
      # "ghostty"
      "visual-studio-code"
      # "zed"

      # messaging
      # "discord"
      # "slack"
      # "signal"

      # other
      "obsidian"
      "1password"
      "1password-cli"
      "utm"
      "chatgpt"
      "windows-app"
      "calibre"
      "alacritty"
      "localsend"
      "omnissa-horizon-client"
      "microsoft-teams"
      # "anki"
      # "brave-browser"
      # "obsidian"
      # "protonvpn"
      # "spotify"
      # "thebrowsercompany-dia"
      # "zen"
    ];
    brews = [
      "qemu"
      "lima"
      "colima"
      "docker"
      # "chromium"
      # "chatgpt"
      # "chatgpt-cli"
    ];
    taps = [
      # "kardolus/chatgpt-cli"
      # "nikitabobko/tap"
    ];
  };
}
