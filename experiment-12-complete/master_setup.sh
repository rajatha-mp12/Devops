#!/bin/bash
# MASTER SETUP SCRIPT — BCSL657D DevOps Lab
# Installs: Java 17, Maven, Gradle 8.6, Jenkins, Git, Ansible
# Compatible with: Ubuntu 22.04 LTS / WSL2
# Usage: chmod +x master_setup.sh && sudo ./master_setup.sh

set -e
RED='\033[0;31m'; GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'

log() { echo -e "${GREEN}[SETUP]${NC} $1"; }
err() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

echo -e "${BLUE}"
echo '=============================================='
echo '  DevOps Lab Master Setup — BCSL657D'
echo '=============================================='
echo -e "${NC}"

# ---- SYSTEM UPDATE ----
log 'Updating system packages...'
apt-get update -y && apt-get upgrade -y
apt-get install -y curl wget unzip git software-properties-common gnupg2 apt-transport-https

# ---- JAVA 17 ----
log 'Installing Java 17...'
apt-get install -y openjdk-17-jdk
echo 'JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> /etc/environment
source /etc/environment
java -version && log 'Java 17 installed!'

# ---- MAVEN ----
log 'Installing Apache Maven...'
apt-get install -y maven
mvn -version && log 'Maven installed!'

# ---- GRADLE ----
log 'Installing Gradle 8.6...'
GRADLE_VERSION=8.6
wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -O /tmp/gradle.zip
unzip -q /tmp/gradle.zip -d /opt/gradle
ln -sf /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle /usr/local/bin/gradle
rm /tmp/gradle.zip
gradle -v && log 'Gradle installed!'

# ---- JENKINS ----
log 'Installing Jenkins...'
wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key 2>/dev/null
echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/' \
  > /etc/apt/sources.list.d/jenkins.list
apt-get update -y && apt-get install -y jenkins
systemctl start jenkins && systemctl enable jenkins
log 'Jenkins installed! URL: http://localhost:8080'

# ---- ANSIBLE ----
log 'Installing Ansible...'
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible
ansible --version && log 'Ansible installed!'

# ---- GIT CONFIG ----
log 'Configuring Git...'
git --version

# ---- SUMMARY ----
echo ''
echo -e "${GREEN}"
echo '=============================================='
echo '  ALL TOOLS INSTALLED SUCCESSFULLY!'
echo '=============================================='
echo ''
echo 'Java:    ' $(java -version 2>&1 | head -1)
echo 'Maven:   ' $(mvn -version 2>&1 | head -1)
echo 'Gradle:  ' $(gradle -v 2>&1 | grep Gradle | head -1)
echo 'Jenkins: running at http://localhost:8080'
echo 'Ansible: ' $(ansible --version | head -1)
echo 'Git:     ' $(git --version)
echo ''
echo 'Jenkins admin password:'
cat /var/lib/jenkins/secrets/initialAdminPassword 2>/dev/null || echo '(start Jenkins first)'
echo -e "${NC}"
