# syntax=docker/dockerfile:1
ARG RELEASE=focal
FROM ghcr.io/linuxserver/baseimage-ubuntu:${RELEASE} as bulldozer-xrdp-backend

# Should resolve DL4006 as much as possible
SHELL ["/bin/sh", "-o", "pipefail", "-c"]

# Set the defaults if not provided
ARG XRDP_PULSE_VERSION=v0.4
ARG GUACD_VERSION=1.1.0

# Backend
RUN sed -i 's/# deb-src/deb-src/g' /etc/apt/sources.list && \
    install-packages build-essential devscripts dpkg-dev git libpulse-dev pulseaudio && \
    apt build-dep -y pulseaudio xrdp && \
    mkdir -p /buildout/var/lib/xrdp-pulseaudio-installer && \
    tmp=$(mktemp -d); cd "$tmp" && \
    pulseaudio_version=$(dpkg-query -W -f='${source:Version}' pulseaudio|awk -F: '{print $2}') && \
    pulseaudio_upstream_version=$(dpkg-query -W -f='${source:Upstream-Version}' pulseaudio) && \
    set -- $(apt-cache policy pulseaudio | fgrep -A1 '***' | tail -1) && \ mirror=$2 && \ suite=${3#*/} \
    && dget -u "$mirror/pool/$suite/p/pulseaudio/pulseaudio_$pulseaudio_version.dsc" && \
    cd "pulseaudio-$pulseaudio_upstream_version" &&  ./configure && \
    cd - &&  git clone https://github.com/neutrinolabs/pulseaudio-module-xrdp.git && \
    cd pulseaudio-module-xrdp &&  git checkout ${XRDP_PULSE_VERSION} && \
    ./bootstrap &&  ./configure PULSE_DIR="$tmp/pulseaudio-$pulseaudio_upstream_version" && \
    make && install -t "/buildout/var/lib/xrdp-pulseaudio-installer" -D -m 644 src/.libs/*.so && \
    cd /tmp && apt-get source xrdp && cd xrdp-* && sed -i 's/--enable-fuse/--disable-fuse/g' debian/rules && \
    debuild -b -uc -us && cp -ax ../xrdp_*.deb /buildout/xrdp.deb

# Frontend Server
RUN install-packages autoconf automake checkinstall freerdp2-dev g++ gcc git libavcodec-dev \
    libavutil-dev libcairo2-dev libjpeg-turbo8-dev libogg-dev libossp-uuid-dev libpulse-dev \
    libssl-dev libswscale-devlibtool libvorbis-dev libwebsockets-dev \ libwebp-dev make && \
    mkdir /tmp/guacd && git clone https://github.com/apache/guacamole-server.git /tmp/guacd && \
    cd /tmp/guacd && git checkout ${GUACD_VERSION} && autoreconf -fi && ./configure --prefix=/usr && \
    make && /usr/bin/list-dependencies.sh "/tmp/guacd/src/guacd/.libs/guacd" $(find /tmp/guacd | grep "so$") \
    > /buildout/DEPENDENCIES.txt && PREFIX=/usr checkinstall -y -D --nodoc \ --pkgname guacd --pkgversion \
    "${GUACD_VERSION}" --pakdir /buildout --exclude "/usr/share/man","/usr/include","/etc"

FROM node:fermium-bullseye-slim as bulldozer-xrdp-frontend

# Should resolve DL4006 as much as possible
SHELL ["/bin/sh", "-o", "pipefail", "-c"]

# Ensures we're root in case shit happens on permissions stuff.
USER root
# Borrow our install-packages script just for this stage.
COPY ../ubuntu-lts-base/overlay/usr/local/bin/install-packages /usr/local/bin/install-packages

ARG GCLIENT_RELEASE=0.1.2
# Install some dev packages and then get the tarball of gclient.
RUN install-packages g++ gcc libpam0g-dev make; if [ -z ${GCLIENT_RELEASE+x} ]; then \
    GCLIENT_RELEASE=$(curl -sX GET "https://api.github.com/repos/linuxserver/gclient/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]'); \
    fi && curl -o /tmp/gclient.tar.gz -L "https://github.com/linuxserver/gclient/archive/${GCLIENT_RELEASE}.tar.gz"; \
    tar xf /tmp/gclient.tar.gz -C /gclient/ --strip-components=1
# Next install dependencies
WORKDIR /gclient
RUN npm install
# Also download websocat too ahead of time.
RUN WEBSOCAT_RELEASE=$(curl -sX GET "https://api.github.com/repos/vi/websocat/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
    curl -o /usr/bin/websocat -L "https://github.com/vi/websocat/releases/download/${WEBSOCAT_RELEASE}/websocat_nossl_amd64-linux-static" && chmod +x /usr/bin/websocat

# docker compose
FROM ghcr.io/linuxserver/docker-compose:amd64-latest as compose

# runtime stage
ARG RELEASE=focal
FROM ghcr.io/ajhalili2006/webtop-ubuntu-base:${RELEASE} as runtime

# copy over libs and installers from build stage
COPY --from=bulldozer-xrdp-backend /buildout/ /buildout
COPY --from=compose /usr/local/bin/docker-compose /usr/local/bin/docker-compose
COPY --from=bulldozer-xrdp-frontend /gclient /gclient
COPY --from=bulldozer-xrdp-frontend /usr/bin/websocat /usr/bin/websocat

# xrdp
RUN ldconfig && install-packages apt-transport-https ca-certificates curl dbus-x11 gawk \
    gnupg2 libfuse2 libx11-dev libxfixes3 libxml2  libxrandr2 openssh-client pulseaudio \
    software-properties-common sudo x11-apps x11-xserver-utils xfonts-base \
	xorgxrdp xrdp xserver-xorg-core xutils zlib1g && dpkg -i /xrdp.deb && rm /xrdp.deb; docker-ce-cli

# Permission chaos
RUN echo "gildedguy:" | chpasswd && usermod -aG sudo abc

# add local files
COPY ./overlay/ /

# ports and volumes
EXPOSE 3389
VOLUME /config