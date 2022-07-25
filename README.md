# Custom Webtop Container Images

This repository contains stuff I use for running an Linuxserver Webtop containers in remote basis, especially in Google Cloud Shell.

## Usage

To simplify typing longer commands for you, we add some scripts to our `scripts` object on [`package.json`](./package.json),
but we use Yarn here. Most of the commands follow the Docker Compose commands, seperated by an colon and followed by
`<desktop-env>-<distro>` OR `<desktop-env>-<distro>-<env>` outside local machines.

```bash
# Build from source or use prebuilt versions on local dev machine
yarn up:<desktop-env>-<distro>
yarn up-ci:<desktop-env>-<distro>

# On Google Cloud Shell?
yarn up:<desktop-env>-<distro>-devshell
yarn up-ci:<desktop-env>-<distro>-devshell   # Or: yarn devshell:<desktop-env>-<distro>

# Gitpod
yarn up:<desktop-env>-<distro>-gp
yarn up-ci:<desktop-env>-<distro>-gp
```

## Variables

* `TAILSCALE_AUTHKEY` - Tailscale authkey, preferrly ephermal ones, to seamlessly connect directly to the RDP server.

## License

GPLv3
