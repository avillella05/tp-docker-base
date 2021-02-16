#!/bin/bash

## Install Registry

IP=$(hostname -I | awk '{print $2}')

echo "START - Install Docker Engine on Ubuntu - "$IP

echo "[1]: Désinstallation ancienne version"
sudo apt-get remove docker docker-engine docker.io containerd runc

echo "[2]: Installation du repository Docker"
sudo apt-get update -qq >/dev/null
sudo apt-get install -qq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    git \
    wget >/dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


echo "[3]: Installation Docker Engine"
sudo apt-get update -qq >/dev/null
sudo apt-get install -qq docker-ce docker-ce-cli containerd.io >/dev/null

echo "[4]: Test bonne installation Docker Engine"
sudo docker run hello-world

echo "END - Install Docker Engine on Ubuntu"

