# Docker images for Brown's Jupyter Hub


This repository contains the dockerfiles to use for singleuser images, spawened by different Jupyter Hub instances at Brown University. These images are in large part based on those maintained by the official Jupyter team https://github.com/jupyter/docker-stacks. We add custom plugins and/or libraries as requested by instructors.

## Builinding the images

* Clone this repository.


* Run the build script to generate Docker images.
```
./build.bash [ -r REGISTRY ] [ image_folder ]
```

The `-r` option can be a docker container registry, e.g. gcr.io/YOUR_ORG. The
singleuser server builds utilize a shared base image specified by
base/Dockerfile. Various other singleuser server images are built from this
specified by {user_type}/Dockerfile. 

For example to build the singleuser image, you would run 
`./build.bash -r browndatasci scipy-plus-lab`

Each docker image is tagged with the git commit hash corresponding with the last git revision of the build files. 


## File / Folder structure

The subdirectories contain the Dockerfiles and scripts for the images used for
this deployment.

## Testing locally

While these images are created with our JupyterHub set up in mind, you can run them locally 

```
docker run -it -p 8888:8888 browndatasci/jupyterhub-datasci-notebook:a1dee96
```


Or 

Attach a `bash` session 

```
docker run -it --entrypoint /bin/bash browndatasci/jupyterhub-datasci-notebook:a1dee96
```
