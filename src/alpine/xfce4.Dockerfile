# Default tag points to Alpine-Xfce4 base
FROM lscr.io/linuxserver/webtop:latest

# Add additional packages
RUN apk install \
       gpg \
       git \
       git-lfs \
       python3 \
       py3-pip \
       zsh \
       seahorse \
       procps --no-cache \
    && git-lfs install --system

RUN wget -O /usr/local/bin/gp-localapp https://go.rtapp.tk/gitpod/localapp/linux-amd64 \
    && sudo chmod +x /usr/local/bin/gp-localapp
