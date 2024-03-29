# development toolkit (Dockerized)

Personal Docker image used for development

### Stack

- Ubuntu 20.04
- .NET 7.0.15
- NodeJS 18.17.1
- Git 2.25.1 and Git LFS 2.9.2
- Docker 24.0.5 and Docker Compose 2.23.3
- Curl 7.68.0
- net-tools 1.60
- ca-certificates 20230311
- gnupg 2.2.19
- libcurl4-openssl-dev 7.68.0
- gcc 4:9.3.0
- g++ 4:9.3.0
- make 4.2.1
- fastjar 2:0.98
- nano 4.8
- iputils-ping 3:20190709-3
- apt-transport-https 2.0.10
- jq 1.6
- [UlisesGascon/opinionated-bash-scripts](https://github.com/UlisesGascon/opinionated-bash-scripts) 0.7.0

### Usage

```bash
docker run -it ulisesgascon/development-toolkit:latest bash
```

```bash
docker run -it ghcr.io/ulisesgascon/development-toolkit:latest bash
```

### Notes

Opinionated bash scripts are available in the folder: `/usr/share/opinionated-bash-scripts`, you can use them as:

```bash
source /usr/share/opinionated-bash-scripts/scripts/version.sh
get_version
```

