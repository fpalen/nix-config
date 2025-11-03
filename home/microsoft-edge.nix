{ pkgs, ... }:
let
  edgePlist = pkgs.writeText "com.microsoft.Edge.plist" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
      "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <!-- Privacidad -->
      <key>BlockThirdPartyCookies</key><true/>
      <key>TrackingPrevention</key><integer>3</integer> <!-- 1=Basic, 2=Balanced, 3=Strict -->
      <key>MetricsReportingEnabled</key><false/>
      <key>PersonalizationReportingEnabled</key><false/>
      <key>PasswordManagerEnabled</key><false/>
      <key>AutofillAddressEnabled</key><false/>
      <key>AutofillCreditCardEnabled</key><false/>

      <!-- PWA forzadas (Teams/Outlook) -->
      <key>WebAppInstallForceList</key>
      <array>
        <dict>
          <key>url</key>
          <string>https://teams.microsoft.com/</string>
          <key>default_launch_container</key>
          <string>window</string>
          <key>create_desktop_shortcut</key><true/>
        </dict>
        <dict>
          <key>url</key>
          <string>https://outlook.office.com/</string>
          <key>default_launch_container</key>
          <string>window</string>
          <key>create_desktop_shortcut</key><true/>
        </dict>
      </array>

      <!-- Varios -->
      <key>DefaultBrowserSettingEnabled</key><false/>
      <key>BackgroundModeEnabled</key><false/>
      <key>HardwareAccelerationModeEnabled</key><true/>
    </dict>
    </plist>
  '';
in
{
  # Copia/instala el .plist en cada switch (root), sobrescribiendo
  launchd.daemons.edge-policies = {
    serviceConfig = {
      Label = "edge-policies.install";
      ProgramArguments = [
        "/bin/sh" "-c"
        "install -m 0644 -o root -g wheel ${edgePlist} '/Library/Managed Preferences/com.microsoft.Edge.plist'"
      ];
      RunAtLoad = true;
    };
    # Garantiza que se ejecute en cada rebuild
    wantedBy = [ "multi-user.target" ];
  };
}
