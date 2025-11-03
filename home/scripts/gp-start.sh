#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Iniciando GlobalProtect..."

# Cargar daemons y agentes
sudo launchctl load /Library/LaunchDaemons/com.paloaltonetworks.gp.pangps.plist 2>/dev/null || true
sudo launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangpa.plist 2>/dev/null || true

# Forzar arranque inmediato de servicios
sudo launchctl kickstart -k system/com.paloaltonetworks.gp.pangps || true
sudo launchctl kickstart -k gui/$(id -u)/com.paloaltonetworks.gp.pangpa || true

# Espera breve para que suba el servicio
sleep 2

# Abre la app si existe
if [ -d "/Applications/GlobalProtect.app" ]; then
  open -a "GlobalProtect"
  echo "🌐 GlobalProtect app abierta."
else
  echo "⚠️ No se encontró /Applications/GlobalProtect.app"
fi

echo "✅ GlobalProtect iniciado correctamente."
