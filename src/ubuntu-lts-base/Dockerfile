# syntax=docker/dockerfile:1
ARG RELEASE=focal
FROM ghcr.io/linuxserver/baseimage-ubuntu:${RELEASE}

# Should resolve DL4006 as much as possible
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy our stuff from overlay directory
COPY overlay/ /

# Scripts copied from Gitpod, with some modifications:
# - https://github.com/gitpod-io/workspace-images/blob/master/base/upgrade-packages for upgrading packages minus
#   the cache
# - https://github.com/gitpod-io/workspace-images/blob/master/base/install-packages on installing packages while
#   keeping stuff below the threashold for Dive to warn.
RUN /usr/local/bin/upgrade-packages; \
    # We'll also install Node.js 14.x ahead of time.
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nodesource-archive-keyring.gpg > /dev/null; \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/nodesourc-archive-keyring.gpg] https://deb.nodesource.com/node_14.x $(lsb_release -cs) main" \
    | sudo tee /etc/apt/sources.list.d/nodesource.list > /dev/null; \
    /usr/local/bin/install-packages git-lfs gh glab dive nodejs
