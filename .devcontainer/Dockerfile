FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

RUN apt-get update && apt-get install -y \
    openjdk-17-jre \
    wget \
    curl \
    unzip \
    ca-certificates \
    sudo \
    git \
    nano \
    vim \
    xterm \
    dbus-x11 \
    xdg-utils \
    mate-desktop-environment-core \
    mate-terminal \
    caja \
    marco \
    mate-panel \
    mate-settings-daemon \
    mate-control-center \
    pluma \
    epiphany-browser \
    make \
    gcc \
    g++ \
    gdb \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libfreetype6 \
    libfontconfig1 \
    libxext6 \
    libx11-6 \
    libxau6 \
    libxdmcp6 \
    libxcb1 \
    libgtk-3-0 \
    libnss3 \
    libasound2 \
    libglu1-mesa \
    libgl1-mesa-glx \
    libegl1 \
    libpulse0 \
    desktop-file-utils \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/installers /opt/microchip /opt/simulide /tmp/mplabx

COPY .devcontainer/scripts/install-mplabx.sh /usr/local/bin/install-mplabx.sh
RUN chmod +x /usr/local/bin/install-mplabx.sh
