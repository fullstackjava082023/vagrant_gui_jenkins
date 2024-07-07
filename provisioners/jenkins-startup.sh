#!/bin/bash

LOGFILE="/var/log/jenkins-startup.log"
exec > >(tee -a ${LOGFILE} )
exec 2> >(tee -a ${LOGFILE} >&2)

echo "Starting Jenkins setup..."

# Add Jenkins repository for Ubuntu
echo "Adding Jenkins repository..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update and upgrade system
echo "Updating package lists..."
sudo apt-get update
echo "Upgrading packages..."
sudo apt-get upgrade -y

# Install dependencies and Jenkins
echo "Installing OpenJDK 17..."
sudo apt-get install -y openjdk-17-jre
echo "Installing Jenkins, Docker, and Git..."
sudo apt-get install -y jenkins docker.io git

# Allow firewall on port 8080
echo "Configuring firewall..."
sudo ufw allow 8080
sudo ufw reload

echo "Jenkins setup complete."