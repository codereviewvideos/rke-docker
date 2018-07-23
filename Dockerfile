FROM alpine:latest

ENV RANCHER_REPOSITORY rancher/rke

WORKDIR /app

RUN echo "Installing Curl" && \
    apk --no-cache add curl > /dev/null && \
    echo "Using Repository: $RANCHER_REPOSITORY" && \
    RANCHER_VERSION=$(curl --silent "https://api.github.com/repos/$RANCHER_REPOSITORY/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    echo "Using Rancher Version: $RANCHER_VERSION" && \
    curl --silent -L "https://github.com/$RANCHER_REPOSITORY/releases/download/$RANCHER_VERSION/rke_linux-amd64" --output rke_linux-amd64 && \
    chmod +x rke_linux-amd64 && \
    export PATH=$PATH:/app/ && \
    rke_linux-amd64 --version

CMD ["/app/rke_linux-amd64"]
