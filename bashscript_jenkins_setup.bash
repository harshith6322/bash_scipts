#!/bin/bash

# error handling
set -euo pipefail
set -x

# update system
sudo apt-get -y update
sudo apt-get -y upgrade

# install Java (JDK 21)
sudo apt install -y fontconfig openjdk-21-jre
java -version

# install Jenkins
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins

# install Docker
sudo apt-get install -y docker.io

# give Docker group permissions
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker

# enable and restart Jenkins
sudo systemctl enable jenkins
sudo systemctl restart jenkins
sudo systemctl status jenkins

# final reboot (this line stops script here — which is okay now)
sudo reboot
