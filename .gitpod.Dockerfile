FROM quay.io/gitpodified-workspace-images/full:latest

RUN brew update; brew upgrade; brew install gh glab shellcheck hadolint
