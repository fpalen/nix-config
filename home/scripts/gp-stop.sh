#!/usr/bin/env bash
set -euo pipefail

echo "🧹 Deteniendo GlobalProtect..."

# Descargar daemons y agentes
sudo launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangpa.plist 2>/dev/null || true
sudo launchctl unload /Library/LaunchDaemons/com.paloaltonetworks.gp.pangps.plist 2>/dev/null || true
sudo launchctl unload /Library/LaunchDaemons/com.paloaltonetworks.gp.pangpa.plist 2>/dev/null || true

# Matar procesos huérfanos
sudo pkill -f GlobalProtect || true
sudo pkill -f PanGPS || true
sudo pkill -f PanGPA || true
sudo pkill -f PanMS || true

# Borrar bloqueos temporales
sudo rm -f /tmp/.gp-session.lock 2>/dev/null || true

echo "✅ GlobalProtect detenido y limpiado completamente."
