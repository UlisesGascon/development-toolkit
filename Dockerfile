FROM ubuntu:20.04

# Metadata
LABEL maintainer="ulises@linux.com"

ARG BUILD_DATE
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="ulisesgascon/development-toolkit"
LABEL org.label-schema.description="Personal Docker image used for development"
LABEL org.label-schema.url="https://github.com/UlisesGascon/dockerized-development-toolkit"
LABEL org.label-schema.vcs-url="https://github.com/UlisesGascon/dockerized-development-toolkit"
LABEL org.label-schema.vendor="Ulises Gascon"
LABEL org.label-schema.docker.cmd="docker run -it ulisesgascon/development-toolkit:latest bash"
LABEL org.label-schema.build-date=$BUILD_DATE

# Install curl, git, net-tools and Docker
RUN apt-get update && apt-get install -y curl git net-tools docker.io

# Install Git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install git-lfs

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Install .NET SDK
RUN curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel Current --install-dir /usr/share/dotnet

# Set the path to include .NET
ENV PATH="$PATH:/usr/share/dotnet"