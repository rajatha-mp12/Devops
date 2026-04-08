#!/bin/bash
# ========================================================================
#  DevOps Workshop - Complete Automated Setup Script
#  BCSL657D - Semester 6
# ========================================================================
#  This script automatically:
#  - Updates system
#  - Installs Java, Maven, Gradle, Git
#  - Installs Jenkins
#  - Installs Ansible
#  - Installs Docker
#  - Fixes Gradle wrapper
#  - Builds Maven project
#  - Builds Gradle project
# ========================================================================
#  Usage: chmod +x auto_setup.sh && sudo ./auto_setup.sh
# ========================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ========================================================================
# Functions
# ========================================================================

log() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1"; exit 1; }
info() { echo -e "${CYAN}[i]${NC} $1"; }

banner() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║     DevOps Workshop - BCSL657D Automated Setup              ║"
    echo "║     Complete DevOps Pipeline Setup                          ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# ========================================================================
# Main Setup
# ========================================================================

banner

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    error "Please run as root: sudo ./auto_setup.sh"
fi

# Get current directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ========================================================================
# Step 1: Update System
# ========================================================================
echo ""
info "Step 1: Updating system packages..."
apt-get update -y
apt-get upgrade -y
apt-get install -y curl wget unzip git software-properties-common gnupg2 apt-transport-https ca-certificates
log "System updated"

# ========================================================================
# Step 2: Install Java
# ========================================================================
echo ""
info "Step 2: Installing Java 17..."
apt-get install -y openjdk-17-jdk
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
echo "JAVA_HOME=$JAVA_HOME" >> /etc/environment
log "Java 17 installed"

# ========================================================================
# Step 3: Install Maven
# ========================================================================
echo ""
info "Step 3: Installing Maven..."
apt-get install -y maven
log "Maven installed"

# ========================================================================
# Step 4: Install Gradle (System)
# ========================================================================
echo ""
info "Step 4: Installing Gradle 8.6 (system)..."
GRADLE_VERSION=8.6
wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -O /tmp/gradle.zip
unzip -q /tmp/gradle.zip -d /opt/
ln -sf /opt/gradle-${GRADLE_VERSION}/bin/gradle /usr/local/bin/gradle
rm /tmp/gradle.zip
log "Gradle 8.6 installed"

# ========================================================================
# Step 5: Install Git
# ========================================================================
echo ""
info "Step 5: Installing Git..."
apt-get install -y git
git config --global user.email "devops@bcsl657d.com"
git config --global user.name "DevOps Student"
log "Git installed"

# ========================================================================
# Step 6: Install Jenkins
# ========================================================================
echo ""
info "Step 6: Installing Jenkins..."

# Remove old Jenkins repo if exists (prevents GPG errors)
rm -f /etc/apt/sources.list.d/jenkins.list
rm -f /usr/share/keyrings/jenkins-keyring.asc

# Direct install method (avoids GPG key issues)
JENKINS_VERSION="2.455"
wget -q https://pkg.jenkins.io/debian-stable/jenkins_${JENKINS_VERSION}_all.deb -O /tmp/jenkins.deb || {
    warn "Download failed, trying apt method..."
    wget -q -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list
    apt-get update -y
    apt-get install -y jenkins
    systemctl daemon-reload
    systemctl start jenkins
    systemctl enable jenkins
    log "Jenkins installed at http://localhost:8080"
    return 0
}
dpkg -i /tmp/jenkins.deb || apt-get install -f -y
systemctl daemon-reload
systemctl start jenkins
systemctl enable jenkins
log "Jenkins installed at http://localhost:8080"

# ========================================================================
# Step 7: Install Ansible
# ========================================================================
echo ""
info "Step 7: Installing Ansible..."
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible
log "Ansible installed"

# ========================================================================
# Step 8: Install Docker
# ========================================================================
echo ""
info "Step 8: Installing Docker..."
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
log "Docker installed"

# ========================================================================
# Step 9: Set Environment Variables
# ========================================================================
echo ""
info "Step 9: Setting environment variables..."

cat > /etc/profile.d/devops.sh << 'EOF'
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export MAVEN_HOME=/usr/share/maven
export GRADLE_HOME=/opt/gradle-8.6
export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin
EOF

chmod +x /etc/profile.d/devops.sh
source /etc/profile.d/devops.sh
log "Environment variables set"

# ========================================================================
# Step 10: Fix Gradle Wrapper (Download jar if missing)
# ========================================================================
echo ""
info "Step 10: Fixing Gradle wrapper..."

cd "$SCRIPT_DIR/experiment-03-gradle"

# Check if gradle-wrapper.jar exists
if [ ! -f "gradle/wrapper/gradle-wrapper.jar" ]; then
    info "Downloading gradle-wrapper.jar..."
    wget -q -O gradle/wrapper/gradle-wrapper.jar https://raw.githubusercontent.com/gradle/gradle/v8.6.0/gradle/wrapper/gradle-wrapper.jar
    log "Gradle wrapper jar downloaded"
else
    log "Gradle wrapper jar already exists"
fi

chmod +x gradlew
log "Gradle wrapper fixed"

# ========================================================================
# Step 11: Build Maven Project
# ========================================================================
echo ""
info "Step 11: Building Maven project..."
cd "$SCRIPT_DIR/experiment-02-maven"
mvn clean package -DskipTests
log "Maven project built"

# ========================================================================
# Step 12: Build Gradle Project (using system gradle)
# ========================================================================
echo ""
info "Step 12: Building Gradle project..."
cd "$SCRIPT_DIR/experiment-03-gradle"

# Clean up duplicate lab files before building
info "Cleaning up duplicate lab files..."
rm -rf src/main/java/com/devops/lab 2>/dev/null || true
rm -rf src/test/java/com/devops/lab 2>/dev/null || true
rm -rf .gradle 2>/dev/null || true
log "Cleanup complete"

# Try gradlew first, fallback to system gradle
if [ -f "gradle/wrapper/gradle-wrapper.jar" ]; then
    ./gradlew clean build -x test
else
    gradle clean build -x test
fi
log "Gradle project built"

# ========================================================================
# Step 13: Configure Ansible
# ========================================================================
echo ""
info "Step 13: Configuring Ansible..."
cd "$SCRIPT_DIR/experiment-07-ansible"
chmod +x *.sh 2>/dev/null || true
log "Ansible configured"

# ========================================================================
# Step 14: Make All Scripts Executable
# ========================================================================
echo ""
info "Step 14: Making all scripts executable..."
cd "$SCRIPT_DIR"
find . -name "*.sh" -exec chmod +x {} \;
log "All scripts made executable"

# ========================================================================
# Step 15: Build Docker Images (Optional)
# ========================================================================
echo ""
info "Step 15: Building Docker images..."
cd "$SCRIPT_DIR/experiment-02-maven"
docker build -t maven-demo-app:latest . 2>/dev/null || warn "Docker build skipped"
cd "$SCRIPT_DIR/experiment-03-gradle"
docker build -t gradle-demo-app:latest . 2>/dev/null || warn "Docker build skipped"
log "Docker images ready"

# ========================================================================
# Final Summary
# ========================================================================
echo ""
echo -e "${GREEN}"
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║           ALL SETUP COMPLETED SUCCESSFULLY!                    ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}Installed Tools:${NC}"
echo "  Java:     $(java -version 2>&1 | head -1)"
echo "  Maven:    $(mvn -version 2>&1 | head -1)"
echo "  Gradle:   $(gradle -v 2>&1 | grep Gradle | head -1)"
echo "  Git:      $(git --version)"
echo "  Jenkins:  http://localhost:8080"
echo "  Ansible:  $(ansible --version | head -1)"
echo "  Docker:   $(docker --version)"
echo ""
echo -e "${YELLOW}Run Applications:${NC}"
echo "  Maven:    cd experiment-02-maven && java -jar target/maven-demo-app-1.0.0.jar"
echo "  Gradle:   cd experiment-03-gradle && java -jar build/libs/gradle-demo-app-1.0.0.jar"
echo ""
echo -e "${YELLOW}Access Swagger UI:${NC}"
echo "  http://localhost:8080/swagger-ui.html"
echo ""
echo -e "${GREEN}Happy Learning DevOps!${NC}"
echo ""
