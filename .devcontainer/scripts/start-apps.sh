#!/bin/bash

export DISPLAY=:1
export HOME=/home/${USER:-vscode}

for i in {1..20}; do
    if xdpyinfo >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

xfce4-terminal --geometry=100x30+80+80 --title="MIC2026 Terminal" &
