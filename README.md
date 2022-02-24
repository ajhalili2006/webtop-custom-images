# Custom Webtop Container Images

This repository contains stuff I use for running an Linuxserver Webtop containers in remote basis, especially in Google Cloud Shell.

## Usage

To simplify typing longer commands for you, we add some scripts to our `scripts` object on [`package.json`](./package.json), but we use Yarn here.

```bash
# build from source and start container
yarn compose-up:xfce4-alpine-devshell        # Optmized for Cloud Shell
yarn compose-up:xfce4-alpine-gp              # optmized for Gitpod
```

## Variables

* `TAILSCALE_AUTHKEY` - Tailscale authkey, preferrly ephermal ones, to seamlessly connect directly to the RDP server.

## License

GPLv3
