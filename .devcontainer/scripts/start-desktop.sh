#!/usr/bin/env bash
set -euo pipefail

USER_HOME="/home/vscode"
DISPLAY_NUM=":1"
VNC_PORT="5901"
NOVNC_PORT="6080"

mkdir -p "${USER_HOME}/.vnc"

cat > "${USER_HOME}/.vnc/xstartup" <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4
EOF

chmod +x "${USER_HOME}/.vnc/xstartup"

rm -f /tmp/.X1-lock
rm -rf /tmp/.X11-unix/X1

tigervncserver -kill :1 >/dev/null 2>&1 || true
pkill -f "websockify.*6080" >/dev/null 2>&1 || true

tigervncserver :1 -geometry 1440x900 -depth 24 -localhost no -SecurityTypes None --I-KNOW-THIS-IS-INSECURE

nohup websockify --web=/usr/share/novnc/ ${NOVNC_PORT} localhost:${VNC_PORT} \
  > "${USER_HOME}/websockify.log" 2>&1 &

echo "Desktop remoto disponível em http://localhost:${NOVNC_PORT}"
