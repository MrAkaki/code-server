FROM debian:stable-slim

# Update image
RUN apt update
RUN apt upgrade -y

RUN apt install -y \
    systemd \
    iputils-ping \
    ca-certificates \    
    wget \
    curl \
    git \
    bash \
    nano \
    sudo

# Create user
RUN useradd -s /bin/bash --home-dir /config/workspace -m coder

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

## Copy config file
COPY /config-files /usr/local/bin
RUN chmod +x /usr/local/bin/*

# Install custom tools

## kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 
RUN curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
RUN install -o root -g root -m 0755 kubectl /bin/kubectl
RUN rm kubectl*
RUN kubectl version --client
ENV KUBECONFIG=/root/.kube/config.yaml

EXPOSE 8443
ENTRYPOINT ["/usr/local/bin/start"]