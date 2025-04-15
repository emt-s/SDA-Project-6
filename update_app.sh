#!/bin/bash

set -e

date

echo "Updating Python application on VM..."
APP_DIR="/home/azureuser/project6/SDA-Project-6"
GIT_REPO="https://github.com/emt-s/SDA-Project-6.git"
BRANCH="main"

#If the folder exist update it from GitHub

if [ -d "$APP_DIR" ]; then
    echo "Cleaning existing repo..."
    sudo -u azureuser bash -c "cd $APP_DIR && git fetch origin && git reset --hard origin/$BRANCH"
else
    echo "Cloning fresh repo..."
    sudo -u azureuser git clone -b $BRANCH "$GIT_REPO" "$APP_DIR"
fi

#Update requirements
sudo -u azureuser /home/azureuser/pr-stage-5/venv/bin/pip install --upgrade pip
sudo -u azureuser /home/azureuser/pr-stage-5/venv/bin/pip install -r "$APP_DIR/requirements.txt"

# Restart the service
sudo systemctl restart backend.service
sudo systemctl restart frontend.service
sudo systemctl restart chroma.service

echo "Python services update completed!"
