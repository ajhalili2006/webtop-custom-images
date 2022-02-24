#hadolint disable=DL3006,DL3007
# Default tag points to Alpine-Xfce4 base
FROM lscr.io/linuxserver/webtop:latest

COPY overlay/ /

# Add additional packages
RUN apk update && apk upgrade && apk add \
       s6-ipcserver gpg git git-lfs python3 py3-pip \
       nodejs npm coreutils htop \
       zsh seahorse procps terminus-font \
       ttf-inconsolata ttf-dejavu \
       font-noto ttf-font-awesome \
       font-noto-extra font-vollkorn font-misc-cyrillic \
       font-mutt-misc font-screen-cyrillic font-winitzki-cyrillic \
       font-cronyx-cyrillic terminus-font font-noto font-noto-thai \
       font-noto-tibetan font-ipa font-sony-misc font-daewoo-misc font-jis-misc \
       font-isas-misc font-noto-emoji libcap tailscale \
    && git-lfs install --system

RUN wget -O /usr/local/bin/gp-localapp https://go.rtapp.tk/gitpod/localapp/linux-amd64 \
    && chmod +x /usr/local/bin/gp-localapp

# Required to ensure the frontend client for browsers doesn't break.
WORKDIR /gclient
RUN npm install

# Google Cloud Shell installs
WORKDIR /usr/local
ARG GCLOUD_CLI_VERSION=374.0.0
RUN set -xe; IMAGE_ARCH=$(apk --print-arch) \
  && wget "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_CLI_VERSION}-linux-$IMAGE_ARCH.tar.gz" -O /usr/local/google-cloud-sdk.tar.gz \
  && tar zxvf /usr/local/google-cloud-sdk.tar.gz \
  && ./google-cloud-sdk/install.sh -q \
  && rm /usr/local/google-cloud-sdk.tar.gz \
  # Some fixes to ensure everything is in PATH
  && ln -s /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud \
  && ln -s /usr/local/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil

WORKDIR /
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/google-cloud-sdk/bin
