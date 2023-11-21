FROM ubuntu:20.04

# Arguments
ARG DEBIAN_FRONTEND=noninteractive
# https://github.com/dotnet/core/issues/2186#issuecomment-671105420
ARG DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
ARG NODE_MAJOR=18

# Metadata (other are added by GitHub Actions)
LABEL maintainer="ulises@linux.com"

# Install Core packages curl, git, net-tools, docker, git-lfs and nodejs
RUN apt-get update && apt-get install -y --no-install-recommends curl=7.68.0-1ubuntu2.20 git=1:2.25.1-1ubuntu3.11 net-tools=1.60+git20180626.aebd88e-1ubuntu1 docker.io=24.0.5-0ubuntu1~20.04.1 ca-certificates=20230311ubuntu0.20.04.1 gnupg=2.2.19-3ubuntu2.2 libcurl4-openssl-dev=7.68.0-1ubuntu2.20 gcc=4:9.3.0-1ubuntu2 g++=4:9.3.0-1ubuntu2 make=4.2.1-1.2 fastjar=2:0.98-6build1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Installation script for Git LFS, Node.js and .NET SDK
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel STS --install-dir /usr/share/dotnet \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" > /etc/apt/sources.list.d/nodesource.list

# Install Additional packages
RUN apt-get update && apt-get install -y --no-install-recommends git-lfs=3.4.0 nodejs=18.18.2-1nodesource1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install Opinionated bash scripts
WORKDIR /home
RUN curl -L https://github.com/UlisesGascon/opinionated-bash-scripts/archive/refs/tags/0.2.1.tar.gz | tar zx \
    && mkdir /usr/share/opinionated-bash-scripts \
    && chmod +x opinionated-bash-scripts*/scripts/*.sh \
    && mv opinionated-bash-scripts*/* /usr/share/opinionated-bash-scripts \
    && rm -rf opinionated-bash-scripts*

# Set the path to include .NET
ENV PATH="$PATH:/usr/share/dotnet"
