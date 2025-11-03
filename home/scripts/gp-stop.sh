#!/usr/bin/env bash
set -euo pipefail

echo "🧹 Deteniendo completamente GlobalProtect..."

# Daemons y agentes
DAEMONS=(
  "com.paloaltonetworks.gp.pangps"
  "com.paloaltonetworks.gp.pangpa"
)

# Descargar servicios correctamente
for svc in "${DAEMONS[@]}"; do
  echo "  ⏹️  Deteniendo $svc ..."
  sudo launchctl bootout system/$svc 2>/dev/null || true
  sudo launchctl bootout gui/$(id -u)/$svc 2>/dev/null || true
done

# Matar procesos restantes
echo "  🔪 Matando procesos..."
sudo pkill -9 -f "GlobalProtect" || true
sudo pkill -9 -f "PanGPS" || true
sudo pkill -9 -f "PanGPA" || true
sudo pkill -9 -f "PanMS" || true

# A veces el helper PanGPAHelper queda colgado
sudo pkill -9 -f "PanGPAHelper" || true

# Espera breve
sleep 1

# Borrar locks y sockets temporales
sudo rm -f /tmp/.gp-session.lock 2>/dev/null || true
sudo rm -rf /Library/Logs/PaloAltoNetworks/GlobalProtect/gpservice.lock 2>/dev/null || true

# Verificación rápida
if pgrep -f GlobalProtect >/dev/null; then
  echo "⚠️ Algunos procesos siguen activos:"
  pgrep -fl GlobalProtect
else
  echo "✅ GlobalProtect detenido correctamente."
fi

