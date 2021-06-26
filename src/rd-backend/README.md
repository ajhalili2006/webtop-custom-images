# Remote Desktop Backend

[dockerfileurl]: https://github.com/linuxserver/docker-baseimage-ubuntu/blob/master/Dockerfile

A custom Docker image for the RD in the browser, based on [Linuxserver.io's Ubuntu Docker Base Image][dockerfileurl].

## Usage

To use this custom Docker image, paste the following line on the first line of your
Dockerfile(s) after any comments/`syntax` stuff.

```dockerfile
# Also available in Red Hat Quay Container Registry as quay.io/ajhalili2006/remote-desktop-backend
FROM ghcr.io/andreijirohhalilidev2006/remote-desktop-backend
```

If you want to use this as part of multi-stage build:

```dockerfile
# Also available in Red Hat Quay Container Registry as quay.io/ajhalili2006/remote-desktop-backend
FROM ghcr.io/andreijirohhalilidev2006/remote-desktop-backend
```
