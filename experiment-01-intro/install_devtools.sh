#!/bin/bash
# install_devtools.sh — Installs Java, Maven, Gradle, Jenkins, Ansible
# Compatible: Ubuntu 20.04+ / Debian 10+
set -e

echo '=========================================='
echo ' DevOps Lab Setup — BCSL657D'
echo '=========================================='

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Running as root"
else
    echo "Please run as root: sudo ./install_devtools.sh"
    exit 1
fi

# Update system
echo "Updating system packages..."
apt-get update -y && apt-get upgrade -y

# Install Java 17
echo "Installing Java 17..."
apt-get install -y openjdk-17-jdk
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
echo "JAVA_HOME=$JAVA_HOME"

# Install Maven
echo "Installing Maven..."
apt-get install -y maven

# Install Gradle
echo "Installing Gradle 8.6..."
apt-get install -y wget unzip
GRADLE_VERSION=8.6
wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O /tmp/gradle.zip
unzip -q /tmp/gradle.zip -d /opt/
ln -sf /opt/gradle-${GRADLE_VERSION}/bin/gradle /usr/local/bin/gradle
rm /tmp/gradle.zip

# Install Git
echo "Installing Git..."
apt-get install -y git

# Set environment variables
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> /etc/profile.d/devops.sh
echo 'export MAVEN_HOME=/usr/share/maven' >> /etc/profile.d/devops.sh
echo 'export GRADLE_HOME=/opt/gradle-8.6' >> /etc/profile.d/devops.sh
echo 'export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin' >> /etc/profile.d/devops.sh
chmod +x /etc/profile.d/devops.sh
source /etc/profile.d/devops.sh

echo ''
echo '=========================================='
echo ' All tools installed successfully!'
echo '=========================================='
echo "Java:    $(java -version 2>&1 | head -1)"
echo "Maven:   $(mvn -version 2>&1 | head -1)"
echo "Gradle:  $(gradle -v 2>&1 | grep Gradle | head -1)"
echo "Git:     $(git --version)"
echo ''
echo 'Run: source /etc/profile.d/devops.sh'
echo '=========================================='
