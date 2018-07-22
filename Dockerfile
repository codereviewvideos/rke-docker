FROM ubuntu:latest

ENV RANCHER_REPOSITORY rancher/rke

WORKDIR /app

RUN echo "Installing Curl" && \
    apt-get update && \
    apt-get install -y curl > /dev/null && \
    echo "Using Repository: $RANCHER_REPOSITORY" && \
    RANCHER_VERSION=$(curl --silent "https://api.github.com/repos/$RANCHER_REPOSITORY/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    echo "Using Rancher Version: $RANCHER_VERSION" && \
    curl --silent -L "https://github.com/$RANCHER_REPOSITORY/releases/download/$RANCHER_VERSION/rke_linux-amd64" --output rke_linux-amd64 && \
    chmod +x rke_linux-amd64 
RUN ./rke_linux-amd64 --version
