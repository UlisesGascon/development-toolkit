FROM ubuntu:20.04

# Arguments
ARG DEBIAN_FRONTEND=noninteractive
# https://github.com/dotnet/core/issues/2186#issuecomment-671105420
ARG DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Metadata (other are added by GitHub Actions)
LABEL maintainer="ulises@linux.com"

# Install Core packages curl, git, net-tools, docker, git-lfs and nodejs
RUN apt-get update && apt-get install -y --no-install-recommends curl=7.68.0-1ubuntu2.20 git=1:2.25.1-1ubuntu3.11 net-tools=1.60+git20180626.aebd88e-1ubuntu1 docker.io=24.0.5-0ubuntu1~20.04.1 ca-certificates=20230311ubuntu0.20.04.1 gnupg=2.2.19-3ubuntu2.2 libcurl4-openssl-dev=7.68.0-1ubuntu2.20 gcc=4:9.3.0-1ubuntu2 g++=4:9.3.0-1ubuntu2 make=4.2.1-1.2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Installation script for Git LFS, Node.js and .NET SDK
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel Current --install-dir /usr/share/dotnet

# Install Additional packages
RUN apt-get update && apt-get install -y --no-install-recommends git-lfs=3.4.0 nodejs=18.17.1-deb-1nodesource1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Set the path to include .NET
ENV PATH="$PATH:/usr/share/dotnet"
