FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

RUN apt-get update && apt-get install -y \
    xfce4 xfce4-terminal dbus-x11 x11-xserver-utils \
    xvfb novnc websockify \
    wget curl unzip ca-certificates sudo \
    openjdk-17-jre \
    libxrender1 libxtst6 libxi6 libfreetype6 libfontconfig1 \
    libxext6 libx11-6 libxau6 libxdmcp6 libxcb1 \
    libgtk-3-0 libnss3 libasound2 \
    make gcc g++ gdb git nano vim \
    && rm -rf /var/lib/apt/lists/*
