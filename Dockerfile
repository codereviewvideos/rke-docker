FROM alpine:latest

ENV RANCHER_REPOSITORY rancher/rke

WORKDIR /app

RUN apk --no-cache add curl && \
    RANCHER_VERSION=$(curl --silent "https://api.github.com/repos/$RANCHER_REPOSITORY/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    echo $RANCHER_VERSION && \
    curl "https://github.com/$RANCHER_REPOSITORY/releases/download/$RANCHER_VERSION/rke_linux-amd64" --output rke_linux-amd64 && \
    chmod +x rke_linux-amd64 && \
    ls -lisa && \
    rke_linux-amd64 --version
