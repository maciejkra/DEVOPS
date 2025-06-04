FROM jenkins/jenkins:lts

USER root

# Instalacja docker CLI
RUN apt-get update && apt-get install -y docker.io curl unzip

# Instalacja kubectl
ENV KUBECTL_VERSION=v1.30.1
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && mv kubectl /usr/local/bin/kubectl

# Instalacja kubeval
RUN curl -sSL https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz | tar xz && \
    mv kubeval /usr/local/bin/ && rm -f kubeval-linux-amd64.tar.gz

# Instalacja pluginów z listy
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER jenkins