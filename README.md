# Custom Webtop Docker Image for my Personal Dotfiles in an Container

## Directories

* [`desktop-frontend`](./src/kde-desktop) - The main Docker image for my choosen desktop environment (KDE)
* [`remote-desktop-frontend`](./src/rd-frontend) - TODO
* [`remote-desktop-backend](./src/rd-backend) - TODO
* [`ubuntu-rootfs-cloudimg`](./src/rootfs-cloudimg) - TODO

## License

Since I copied them from the following repos below, GPL v3 is automgaically applied as the repository license:

* https://github.com/linuxserver/docker-webtop/tree/ubuntu-mate for `src/kde-desktop` directory for the KDE desktop stuff
* https://github.com/linuxserver/docker-baseimage-rdesktop-web for `src/rd-frontend` directory for the frontend
* https://github.com/linuxserver/docker-baseimage-rdesktop for `src/rd-backend` directory for backend
* https://github.com/linuxserver/docker-baseimage-ubuntu/tree/focal for `src/rootfs-cloudimg` directory, where the Ubuntu Core image is built
