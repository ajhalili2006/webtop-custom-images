# RootFS Clouid Image (in Ubuntu LTS)

[appurl]: https://cloud-images.ubuntu.com
[dockerfileurl]: https://github.com/linuxserver/docker-baseimage-ubuntu/blob/master/Dockerfile

A custom base image built with [Ubuntu cloud image][appurl] and [S6 overlay](https://github.com/just-containers/s6-overlay), based on [Linuxserver.io's Ubuntu Docker Base Image][dockerfileurl].

## Usage

To use this custom Docker image, paste the following line on the first line of your
Dockerfile(s) after any comments/`syntax` stuff.

```dockerfile
# Also available in Red Hat Quay Container Registry as quay.io/ajhalili2006/ubuntu-cloudimg-rootfs
FROM ghcr.io/andreijirohhalilidev2006/ubuntu-cloudimg-rootfs
```

If you want to use this as part of multi-stage build:

```dockerfile
# Also available in Red Hat Quay Container Registry as quay.io/ajhalili2006/ubuntu-cloudimg-rootfs
FROM ghcr.io/andreijirohhalilidev2006/ubuntu-cloudimg-rootfs as builder
```

## Why Ubuntu LTS?

I always consider stability over feature-packed, because security is one of the protities I focus when it comes to building production-grade containers. While I may need to automate stuff, this should be fine.
