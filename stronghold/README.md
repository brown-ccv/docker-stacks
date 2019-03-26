# Docker Stacks
Home of docker/singularity containers managed by the Data Science Practice build for Stronghold tenants

## Getting Started

* Pre-requisites:
    * Docker
    * DockerHub account (optional)

* Downloading the images
    ```bash
    docker pull REGISTRY/TAG:TAG
    ```

* Clone this repository
    ```bash
    git clone https://github.com/brown-data-science/docker-stacks.git
    ```

* Run the build script to generate Docker images.
    ```bash
    ./build.bash [ -r REGISTRY ] [ image_folder ]
    ```

    The `-r` option can be a docker container registry, e.g. hub.docker/YOUR_ORG.

Notes:
* Each docker image is tagged with the git commit hash corresponding with the last git revision of the build files.
* These images are also intended to use by Singularity, therefore any content placed in $HOME and /tmp/ will be overwritten or inaccessible

---
## Available Images

* [Julia Base](#julia-base)
* [Julia Data Science](#julia-data-science)
* BCBI Base
* [Ctakes](#ctakes)
---
## Julia Base

### Repository

This [repo](https://hub.docker.com/r/browndatasci/julia_base/) lives in DockeHub.

### Pull Command

```bash
docker pull browndatasci/julia_base:$TAG
```

`$TAG` must be specified

### Build image
```bash
./docker_build.bash -r browndatasci julia-datasci-bio
```

### Run docker image

The image can be call as an executable with the desired application. E.g.,

```bash
docker run -it browndatasci/julia_base:tag bash
docker run -it browndatasci/julia_base:tag julia
docker run -it browndatasci/julia_base:tag mysql -h 'hostname' -u 'username' -p
```

----
## Julia Data Science

Appends stats, and machine learning packages to Julia's base image

### Build image
```
./docker_build.bash -r brownccv julia-datasci-bio
```

---
## Ctakes

Appends stats, and machine learning packages to Julia's base image

### Build image
```
./docker_build.bash -r browndatasci ctakes
```

### Run docker image

The image can be call as an executable with the desired application

```bash
docker run -it browndatasci/julia_datasci:tag bash
docker run -it browndatasci/julia_datasci:tag julia
docker run -it browndatasci/julia_datasci:tag mysql -h 'hostname' -u 'username' -p
```
