ARG RELEASE=focal
FROM ghcr.io/linuxserver/baseimage-ubuntu:${RELEASE}

# Copy our stuff from overlay directory
COPY overlay/ /

# Scripts copied from Gitpod, with some modifications:
# - https://github.com/gitpod-io/workspace-images/blob/master/base/upgrade-packages for upgrading packages minus
#   the cache
# - https://github.com/gitpod-io/workspace-images/blob/master/base/install-packages on installing packages while
#   keeping stuff below the threashold for Dive to warn.
RUN /usr/local/bin/upgrade-packages; \
    /usr/local/bin/install-packages git-lfs gh glab dive
