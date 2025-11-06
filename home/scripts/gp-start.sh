#!/usr/bin/env bash
# Arranca GlobalProtect en macOS de forma robusta:
# - Carga daemons/agents con launchctl *bootstrap* (moderno)
# - Kickstart para forzar arranque
# - Espera a que los procesos aparezcan con timeout
# - Abre la app (opcional) o solo servicios (--no-gui)
# - --force: intenta parar restos antes de iniciar

set -euo pipefail

# ===== Config =====
DAEMON_PLIST="/Library/LaunchDaemons/com.paloaltonetworks.gp.pangps.plist"
AGENT_PLIST="/Library/LaunchAgents/com.paloaltonetworks.gp.pangpa.plist"
DAEMON_LABEL="com.paloaltonetworks.gp.pangps"
AGENT_LABEL="com.paloaltonetworks.gp.pangpa"
APP_PATH="/Applications/GlobalProtect.app"
TIMEOUT="${TIMEOUT:-20}"   # segundos máx. de espera por cada servicio

# ===== Opciones =====
OPEN_GUI=1
FORCE=0

usage() {
  cat <<USAGE
Uso: $(basename "$0") [--no-gui] [--force] [--timeout N]

  --no-gui     No abre la app GlobalProtect (solo servicios)
  --force      Intenta parar restos antes de iniciar (limpieza leve)
  --timeout N  Segundos por cada espera de servicio (por defecto: ${TIMEOUT})

Ejemplos:
  $(basename "$0")                 # servicios + abre app
  $(basename "$0") --no-gui        # solo servicios
  $(basename "$0") --force         # limpia restos y arranca
USAGE
}

while [[ "${1:-}" ]]; do
  case "$1" in
    --no-gui) OPEN_GUI=0 ;;
    --force)  FORCE=1 ;;
    --timeout) shift; TIMEOUT="${1:-10}" ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Opción no reconocida: $1"; usage; exit 1 ;;
  esac
  shift || true
done

log() { printf "%s %s\n" "$(date '+%H:%M:%S')" "$*"; }
wait_for_proc() {
  # $1 = patrón pgrep, $2 = timeout
  local pat="$1"; local to="${2:-$TIMEOUT}"
  local i=0
  while ! pgrep -f "$pat" >/dev/null 2>&1; do
    (( i++ >= to )) && return 1
    sleep 1
  done
  return 0
}

# --- Descubrir plists/labels instalados ---
DAEMON_PLIST=""
AGENT_PLIST=""
for p in \
  /Library/LaunchDaemons/com.paloaltonetworks.gp.pangps.plist \
  /Library/LaunchDaemons/com.paloaltonetworks.gp.*.plist
do [[ -f "$p" ]] && DAEMON_PLIST="$p" && break; done

for p in \
  /Library/LaunchAgents/com.paloaltonetworks.gp.pangpa.plist \
  /Library/LaunchAgents/com.paloaltonetworks.gp.*.plist
do [[ -f "$p" ]] && AGENT_PLIST="$p" && break; done

# Si no encontramos plists, probamos etiquetas conocidas
DAEMON_LABEL="com.paloaltonetworks.gp.pangps"
AGENT_LABEL="com.paloaltonetworks.gp.pangpa"

# Intentar leer Label real del plist si existe
PLISTBUDDY="/usr/libexec/PlistBuddy"
if [[ -n "$DAEMON_PLIST" && -x "$PLISTBUDDY" ]]; then
  set +e; L=$("$PLISTBUDDY" -c 'Print :Label' "$DAEMON_PLIST" 2>/dev/null); set -e
  [[ -n "${L:-}" ]] && DAEMON_LABEL="$L"
fi
if [[ -n "$AGENT_PLIST" && -x "$PLISTBUDDY" ]]; then
  set +e; L=$("$PLISTBUDDY" -c 'Print :Label' "$AGENT_PLIST" 2>/dev/null); set -e
  [[ -n "${L:-}" ]] && AGENT_LABEL="$L"
fi

# ===== (Opcional) Limpieza leve previa =====
if [[ "$FORCE" -eq 1 ]]; then
  log "🔧 Limpieza leve (--force): sacando servicios activos"
  sudo launchctl bootout system/"$DAEMON_LABEL"   >/dev/null 2>&1 || true
  sudo launchctl bootout gui/$(id -u)/"$AGENT_LABEL" >/dev/null 2>&1 || true

  # Mata procesos colgados (sin ser agresivo con -9 aquí)
  sudo pkill -f "PanGPS" 2>/dev/null || true
  sudo pkill -f "PanGPA" 2>/dev/null || true
  sudo pkill -f "GlobalProtect" 2>/dev/null || true
fi

# ===== Carga (bootstrap) y arranque (kickstart) =====
log "🚀 Iniciando GlobalProtect…"

# Carga plists si no estaban registrados
sudo launchctl bootstrap system "$DAEMON_PLIST"  >/dev/null 2>&1 || true
sudo launchctl bootstrap gui/$(id -u) "$AGENT_PLIST" >/dev/null 2>&1 || true

# Kickstart para arrancar ya
sudo launchctl kickstart -k system/"$DAEMON_LABEL"   >/dev/null 2>&1 || true
sudo launchctl kickstart -k gui/$(id -u)/"$AGENT_LABEL" >/dev/null 2>&1 || true

# ===== Espera a que los procesos aparezcan =====
log "⏳ Esperando a PanGPS (daemon) hasta ${TIMEOUT}s…"
if ! wait_for_proc "PanGPS" "$TIMEOUT"; then
  echo "❌ PanGPS no arrancó dentro del timeout."
  exit 2
fi

log "⏳ Esperando a PanGPA (agent) hasta ${TIMEOUT}s…"
if ! wait_for_proc "PanGPA" "$TIMEOUT"; then
  echo "❌ PanGPA no arrancó dentro del timeout."
  exit 3
fi

# ===== Abre la app (opcional) =====
if [[ "$OPEN_GUI" -eq 1 ]]; then
  if [[ -d "$APP_PATH" ]]; then
    # Solo si no está ya abierta
    if ! pgrep -f "GlobalProtect.app" >/dev/null 2>&1; then
      log "🪟 Abriendo la app de GlobalProtect…"
      open -a "GlobalProtect" || true
    fi
  else
    log "⚠️  No se encontró $APP_PATH; servicios iniciados igualmente."
  fi
else
  log "✅ Servicios iniciados (sin abrir GUI por --no-gui)."
fi

log "✅ GlobalProtect iniciado correctamente."
