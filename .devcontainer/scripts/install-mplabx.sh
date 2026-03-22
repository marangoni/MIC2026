#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="/opt/microchip/mplabx"
ASSET_DIR="/workspaces/MIC2026/.devcontainer/assets"
TMP_DIR="/tmp/mplabx-install"

mkdir -p "${TMP_DIR}"
cd "${TMP_DIR}"

if [ ! -f "${ASSET_DIR}/MPLABX-v6.20-linux-installer.tar" ]; then
    echo "Instalador não encontrado em ${ASSET_DIR}"
    echo "Coloque o arquivo MPLABX-v6.20-linux-installer.tar em .devcontainer/assets/"
    exit 1
fi

cp "${ASSET_DIR}/MPLABX-v6.20-linux-installer.tar" .

tar -xf MPLABX-v6.20-linux-installer.tar

INSTALLER="$(find . -maxdepth 1 -type f -name 'MPLABX-v6.20-linux-installer.sh' | head -n 1)"

if [ -z "${INSTALLER}" ]; then
    echo "Instalador .sh não encontrado após extrair o tar."
    exit 1
fi

chmod +x "${INSTALLER}"

"${INSTALLER}" --mode unattended --unattendedmodeui none --installdir "${INSTALL_DIR}"

ln -sf "${INSTALL_DIR}/bin/mplab_ide" /usr/local/bin/mplabx || true
