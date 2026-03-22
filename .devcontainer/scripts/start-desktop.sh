#!/usr/bin/env bash
set -euo pipefail

export USER_HOME="/home/vscode"
export DISPLAY=":1"
export VNC_PORT="5901"
export NOVNC_PORT="6080"

mkdir -p "${USER_HOME}/.vnc"

cat > "${USER_HOME}/.vnc/xstartup" <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4
EOF

chmod +x "${USER_HOME}/.vnc/xstartup"

# Remove locks/sockets antigos, se existirem
rm -f /tmp/.X1-lock
rm -rf /tmp/.X11-unix/X1

# Mata instâncias antigas, se houver
vncserver -kill :1 >/dev/null 2>&1 || true
pkill -f "websockify.*6080" >/dev/null 2>&1 || true

# Inicia o TigerVNC
vncserver :1 -geometry 1440x900 -depth 24 -localhost no

# Inicia o noVNC/websockify
nohup websockify --web=/usr/share/novnc/ ${NOVNC_PORT} localhost:${VNC_PORT} \
  > "${USER_HOME}/websockify.log" 2>&1 &

# Escreve no console uma URL localhost para ajudar o Codespaces a detectar a porta
echo "Desktop remoto disponível em http://localhost:${NOVNC_PORT}"
