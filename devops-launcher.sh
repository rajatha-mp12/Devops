#!/bin/bash
# devops-launcher.sh — Interactive UI for DevOps Tools
# Usage: chmod +x devops-launcher.sh && ./devops-launcher.sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${CYAN}"
echo '╔════════════════════════════════════════════════════════════╗'
echo '║          DevOps Workshop — BCSL657D Launcher               ║'
echo '╚════════════════════════════════════════════════════════════╝'
echo -e "${NC}"

show_menu() {
    echo ""
    echo -e "${YELLOW}Select an option:${NC}"
    echo ""
    echo -e "${GREEN}  [1]${NC}  Maven    — Build and manage Java projects"
    echo -e "${GREEN}  [2]${NC}  Gradle   — Modern build automation"
    echo -e "${GREEN}  [3]${NC}  Jenkins  — CI/CD Pipeline"
    echo -e "${GREEN}  [4]${NC}  Ansible  — Configuration Management"
    echo -e "${GREEN}  [5]${NC}  Azure DevOps — Build & Release Pipelines"
    echo -e "${GREEN}  [6]${NC}  Docker   — Container commands"
    echo -e "${GREEN}  [7]${NC}  All Tools — Show version info"
    echo -e "${GREEN}  [0]${NC}  Exit"
    echo ""
}

maven_menu() {
    clear
    echo -e "${BLUE}====== Maven Menu ======${NC}"
    echo ""
    echo -e "${GREEN}  [1]${NC}  mvn --version"
    echo -e "${GREEN}  [2]${NC}  mvn clean"
    echo -e "${GREEN}  [3]${NC}  mvn compile"
    echo -e "${GREEN}  [4]${NC}  mvn test"
    echo -e "${GREEN}  [5]${NC}  mvn package"
    echo -e "${GREEN}  [6]${NC}  mvn clean package"
    echo -e "${GREEN}  [7]${NC}  mvn clean package -DskipTests"
    echo -e "${GREEN}  [8]${NC}  mvn install"
    echo -e "${GREEN}  [9]${NC}  Run custom Maven command"
    echo -e "${GREEN}  [0]${NC}  Back to main menu"
    echo ""
    read -p "Enter choice: " choice
    
    case $choice in
        1) mvn --version ;;
        2) cd experiment-02-maven && mvn clean ;;
        3) cd experiment-02-maven && mvn compile ;;
        4) cd experiment-02-maven && mvn test ;;
        5) cd experiment-02-maven && mvn package ;;
        6) cd experiment-02-maven && mvn clean package ;;
        7) cd experiment-02-maven && mvn clean package -DskipTests ;;
        8) cd experiment-02-maven && mvn install ;;
        9) 
            echo "Enter custom Maven command:"
            read cmd
            cd experiment-02-maven && mvn $cmd
            ;;
        0) return ;;
    esac
}

gradle_menu() {
    clear
    echo -e "${BLUE}====== Gradle Menu ======${NC}"
    echo ""
    echo -e "${GREEN}  [1]${NC}  gradle --version"
    echo -e "${GREEN}  [2]${NC}  gradle clean"
    echo -e "${GREEN}  [3]${NC}  gradle build"
    echo -e "${GREEN}  [4]${NC}  gradle test"
    echo -e "${GREEN}  [5]${NC}  gradle run"
    echo -e "${GREEN}  [6]${NC}  gradle clean build"
    echo -e "${GREEN}  [7]${NC}  gradle tasks"
    echo -e "${GREEN}  [8]${NC}  gradle hello (custom task)"
    echo -e "${GREEN}  [9]${NC}  Run custom Gradle command"
    echo -e "${GREEN}  [0]${NC}  Back to main menu"
    echo ""
    read -p "Enter choice: " choice
    
    case $choice in
        1) gradle --version ;;
        2) cd experiment-03-gradle && chmod +x gradlew && ./gradlew clean ;;
        3) cd experiment-03-gradle && chmod +x gradlew && ./gradlew build ;;
        4) cd experiment-03-gradle && chmod +x gradlew && ./gradlew test ;;
        5) cd experiment-03-gradle && chmod +x gradlew && ./gradlew run ;;
        6) cd experiment-03-gradle && chmod +x gradlew && ./gradlew clean build ;;
        7) cd experiment-03-gradle && chmod +x gradlew && ./gradlew tasks ;;
        8) cd experiment-03-gradle && chmod +x gradlew && ./gradlew hello ;;
        9) 
            echo "Enter custom Gradle command:"
            read cmd
            cd experiment-03-gradle && chmod +x gradlew && ./gradlew $cmd
            ;;
        0) return ;;
    esac
}

jenkins_menu() {
    clear
    echo -e "${BLUE}====== Jenkins Menu ======${NC}"
    echo ""
    echo -e "${GREEN}  [1]${NC}  Jenkins status"
    echo -e "${GREEN}  [2]${NC}  Start Jenkins"
    echo -e "${GREEN}  [3]${NC}  Stop Jenkins"
    echo -e "${GREEN}  [4]${NC}  Restart Jenkins"
    echo -e "${GREEN}  [5]${NC}  Open Jenkins UI (http://localhost:8080)"
    echo -e "${GREEN}  [6]${NC}  View Jenkins logs"
    echo -e "${GREEN}  [0]${NC}  Back to main menu"
    echo ""
    read -p "Enter choice: " choice
    
    case $choice in
        1) systemctl status jenkins ;;
        2) sudo systemctl start jenkins ;;
        3) sudo systemctl stop jenkins ;;
        4) sudo systemctl restart jenkins ;;
        5) echo "Opening Jenkins at http://localhost:8080" ;;
        6) sudo journalctl -u jenkins -n 50 ;;
        0) return ;;
    esac
}

ansible_menu() {
    clear
    echo -e "${BLUE}====== Ansible Menu ======${NC}"
    echo ""
    echo -e "${GREEN}  [1]${NC}  ansible --version"
    echo -e "${GREEN}  [2]${NC}  ansible all -i hosts.ini -m ping"
    echo -e "${GREEN}  [3]${NC}  ansible-playbook --syntax-check"
    echo -e "${GREEN}  [4]${NC}  Run setup_webserver.yml (dry-run)"
    echo -e "${GREEN}  [5]${NC}  Run main.yml (install Java/Maven/Gradle)"
    echo -e "${GREEN}  [6]${NC}  List all hosts"
    echo -e "${GREEN}  [0]${NC}  Back to main menu"
    echo ""
    read -p "Enter choice: " choice
    
    case $choice in
        1) ansible --version ;;
        2) cd experiment-07-ansible && ansible all -i hosts.ini -m ping ;;
        3) cd experiment-07-ansible && ansible-playbook -i hosts.ini setup_webserver.yml --syntax-check ;;
        4) cd experiment-07-ansible && ansible-playbook -i hosts.ini setup_webserver.yml --check ;;
        5) cd experiment-07-ansible && ansible-playbook -i hosts.ini playbooks/main.yml ;;
        6) cd experiment-07-ansible && ansible all -i hosts.ini --list-hosts ;;
        0) return ;;
    esac
}

azure_menu() {
    clear
    echo -e "${BLUE}====== Azure DevOps Menu ======${NC}"
    echo ""
    echo -e "${YELLOW}Note: Azure DevOps requires azure-pipelines.yml in your repo${NC}"
    echo ""
    echo -e "${GREEN}  [1]${NC}  View basic build pipeline (YAML)"
    echo -e "${GREEN}  [2]${NC}  View Gradle build pipeline"
    echo -e "${GREEN}  [3]${NC}  View complete CI/CD pipeline"
    echo -e "${GREEN}  [4]${NC}  Copy pipeline to Azure DevOps"
    echo -e "${GREEN}  [0]${NC}  Back to main menu"
    echo ""
    read -p "Enter choice: " choice
    
    case $choice in
        1) cat experiment-09-azure-devops/azure-pipelines.yml ;;
        2) cat experiment-10-build-pipeline/azure-pipelines-gradle.yml ;;
        3) cat experiment-12-complete/azure-pipelines-complete.yml ;;
        4) echo "Copy the YAML files to your Azure DevOps repo" ;;
        0) return ;;
    esac
}

docker_menu() {
    clear
    echo -e "${BLUE}====== Docker Menu ======${NC}"
    echo ""
    echo -e "${GREEN}  [1]${NC}  docker --version"
    echo -e "${GREEN}  [2]${NC}  docker ps"
    echo -e "${GREEN}  [3]${NC}  docker images"
    echo -e "${GREEN}  [4]${NC}  Build Maven Docker image"
    echo -e "${GREEN}  [5]${NC}  Build Gradle Docker image"
    echo -e "${GREEN}  [6]${NC}  Run Maven app container"
    echo -e "${GREEN}  [7]${NC}  docker-compose up"
    echo -e "${GREEN}  [0]${NC}  Back to main menu"
    echo ""
    read -p "Enter choice: " choice
    
    case $choice in
        1) docker --version ;;
        2) docker ps ;;
        3) docker images ;;
        4) cd experiment-02-maven && docker build -t devops-maven-app:latest . ;;
        5) cd experiment-03-gradle && docker build -t devops-gradle-app:latest . ;;
        6) docker run -p 8080:8080 devops-maven-app:latest ;;
        7) docker-compose up 2>/dev/null || echo "No docker-compose.yml found" ;;
        0) return ;;
    esac
}

show_versions() {
    clear
    echo -e "${CYAN}====== All Tools Versions ======${NC}"
    echo ""
    echo -e "${YELLOW}Java:${NC}"
    java -version 2>&1 | head -3
    echo ""
    echo -e "${YELLOW}Maven:${NC}"
    mvn -version 2>&1 | head -3
    echo ""
    echo -e "${YELLOW}Gradle:${NC}"
    gradle --version 2>&1 | head -3
    echo ""
    echo -e "${YELLOW}Jenkins:${NC}"
    jenkins --version 2>/dev/null || systemctl status jenkins | head -3
    echo ""
    echo -e "${YELLOW}Ansible:${NC}"
    ansible --version 2>&1 | head -3
    echo ""
    echo -e "${YELLOW}Docker:${NC}"
    docker --version 2>/dev/null || echo "Docker not installed"
    echo ""
    echo -e "${YELLOW}Git:${NC}"
    git --version
    echo ""
}

while true; do
    show_menu
    read -p "Enter choice (0-7): " main_choice
    
    case $main_choice in
        1) maven_menu ;;
        2) gradle_menu ;;
        3) jenkins_menu ;;
        4) ansible_menu ;;
        5) azure_menu ;;
        6) docker_menu ;;
        7) show_versions ;;
        0) 
            echo -e "${GREEN}Thank you for using DevOps Launcher!${NC}"
            exit 0
            ;;
        *) 
            echo -e "${RED}Invalid option!${NC}"
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
done
