#!/usr/bin/env bash
set -euo pipefail

echo "🔁 Reiniciando servicios de GlobalProtect..."

sudo launchctl kickstart -k system/com.paloaltonetworks.gp.pangps || true
sudo launchctl kickstart -k gui/$(id -u)/com.paloaltonetworks.gp.pangpa || true

echo "✅ GlobalProtect reiniciado correctamente."
