FROM jenkins/jenkins:lts

USER root

# Install base tools + docker + maven
RUN apt-get update && \
    apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    docker.io \
    maven && \
    apt-get clean

# Install Azure CLI (fixed repo)
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ jammy main" > /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli

# Give docker access
RUN usermod -aG docker jenkins

USER jenkins
