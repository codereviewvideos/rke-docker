FROM alpine:latest

ENV RANCHER_REPOSITORY rancher/rke

WORKDIR /app

RUN apk --no-cache add curl && \
    curl --silent "https://api.github.com/repos/$RANCHER_REPOSITORY/releases/latest" | \
    grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' &&                                 \
    chmod +x rke_linux-amd64 && ./rke_linux-amd64 --version
