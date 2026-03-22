#!/usr/bin/env bash
set -euo pipefail

cd /tmp/mplabx

# MPLAB X IDE 6.30 Linux - download oficial Microchip
MPLABX_TAR="/MPLABX-v6.20-linux-installer.tar"
MPLABX_URL="https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/MPLABX-v6.20-linux-installer.tar"

wget -O "${MPLABX_TAR}" "${MPLABX_URL}"

tar -xf "${MPLABX_TAR}"

INSTALLER="$(find . -maxdepth 1 -type f -name 'MPLABX-v*-linux-installer.sh' | head -n 1)"

chmod +x "${INSTALLER}"

# Instalação silenciosa
"${INSTALLER}" --mode unattended --unattendedmodeui none --installdir /opt/microchip/mplabx

# Atalho de conveniência
ln -sf /opt/microchip/mplabx/bin/mplab_ide /usr/local/bin/mplabx || true
