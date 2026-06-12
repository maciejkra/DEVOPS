FROM jenkins/jenkins:lts

USER root

# TARGETARCH (amd64/arm64) jest ustawiane automatycznie przez docker build -
# dzieki temu obraz zbuduje sie poprawnie tez na Macach Apple Silicon (arm64).
ARG TARGETARCH

# Instalacja docker CLI
RUN curl -fsSL https://get.docker.com | sh

# Instalacja kubectl
ENV KUBECTL_VERSION=v1.34.1
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" && \
    chmod +x kubectl && mv kubectl /usr/local/bin/kubectl

# Instalacja kubeconform (nastepca kubeval - kubeval jest archived/nieutrzymywany)
RUN curl -sSL "https://github.com/yannh/kubeconform/releases/download/v0.7.0/kubeconform-linux-${TARGETARCH}.tar.gz" | tar xz && \
    mv kubeconform /usr/local/bin/ && rm -f kubeconform-linux-${TARGETARCH}.tar.gz

# Instalacja pluginów z listy
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER jenkins