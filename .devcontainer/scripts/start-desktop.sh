#!/usr/bin/env bash
set -e

export DISPLAY=:1

pgrep -f "Xvfb :1" >/dev/null || Xvfb :1 -screen 0 1440x900x24 &
sleep 2

pgrep -f "xfce4-session" >/dev/null || startxfce4 &
sleep 2

pgrep -f "websockify.*6080" >/dev/null || websockify --web=/usr/share/novnc/ 6080 localhost:5900 &
