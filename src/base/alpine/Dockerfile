FROM alpine:edge

# set version for s6 overlay
ARG OVERLAY_VERSION="v2.2.0.3"
ARG OVERLAY_ARCH="amd64"

# add s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}-installer /tmp/
RUN chmod +x /tmp/s6-overlay-${OVERLAY_ARCH}-installer && /tmp/s6-overlay-${OVERLAY_ARCH}-installer / \
    && rm /tmp/s6-overlay-${OVERLAY_ARCH}-installer
COPY patch/ /tmp/patch

# environment variables
ENV PS1="$(whoami)@$(hostname):$(pwd)\\$ " HOME="/root" TERM="xterm"

RUN apk add --no-cache  \
        curl \
        patch \
        tar \
        bash \
        ca-certificates \
        coreutils \
        procps \
        shadow \
        tzdata && \
 groupmod -g 1000 stellapent-cier && \
 useradd -u 33333 -U -d /config -s /bin/false gildedguy && \
 usermod -G stellapent-cier abc && \
 mkdir -p /app /config /defaults && \
 mv /usr/bin/with-contenv /usr/bin/with-contenvb && \
 patch -u /etc/s6/init/init-stage2 -i /tmp/patch/etc/s6/init/init-stage2.patch && \
 rm -rf /tmp/*

# add local files
COPY overlay/ /

ENTRYPOINT ["/init"]
