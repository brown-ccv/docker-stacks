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
    git clone https://github.com/brown-ccv/docker-stacks.git
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
* [Julia Data Science Python](#julia-data-science-python)
* [Julia Biojulia](#biojulia)
* [Julia MLJ](#julia-mlj)
* BCBI Base
* [Ctakes](#ctakes)
---
## Julia Base

### Repository

This [repo](https://hub.docker.com/r/brownccv/sh-julia/) lives in DockeHub.

### Pull Command

```bash
docker pull brownccv/sh-julia:$TAG
```

`$TAG` must be specified

### Build image
```bash
./docker_build.bash -r brownccv julia-datasci
```

### Run docker image

The image can be call as an executable with the desired application. E.g.,

```bash
docker run -it brownccv/julia_base:tag bash
docker run -it brownccv/julia_base:tag julia
docker run -it brownccv/julia_base:tag mysql -h 'hostname' -u 'username' -p
```

----

## Julia Data Science

Appends stats, and machine learning packages to Julia's base image

### Build image
```
./docker_build.bash -r brownccv julia-datasci
```

## Julia Data Science Python

Appends stats, machine learning, and python-related packages to Julia's base image

### Build image
```
./docker_build.bash -r brownccv julia-datasci-py
```

## BioJulia
Appends BioJulia packages to Julia Data Science image

### Build image
```
./docker_build.bash -r brownccv julia-datasci-bio
```

## Julia MLJ
Appends MLJ-related packages to Julia Data Science Python image

### Build image
```
./docker_build.bash -r brownccv julia-datasci-py-mlj
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
docker run -it brownccv/julia-datasci:tag bash
docker run -it brownccv/julia-datasci:tag julia
docker run -it brownccv/julia-datasci:tag mysql -h 'hostname' -u 'username' -p
```
