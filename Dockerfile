# Start from an Ubuntu image
FROM ubuntu:20.04

# Install curl (required to install Node.js and .NET SDK)
RUN apt-get update && apt-get install -y curl git

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

# Install Docker
RUN apt-get install -y docker.io

WORKDIR /home
