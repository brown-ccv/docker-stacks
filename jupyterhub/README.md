# Docker images for Brown's Jupyter Hub


This repository contains the dockerfiles to use for singleuser images, spawened by different Jupyter Hub instances at Brown University. These images are in large part based on those maintained by the official Jupyter team https://github.com/jupyter/docker-stacks. We add custom plugins and/or libraries as requested by instructors.

## Builinding the images

* Clone this repository.


* Run the build script to generate Docker images.
```
./docker_build.bash [ -r REGISTRY ] [-t NAMED_TAG] [ image_folder ]
```

The `-r` is the docker container registry. Building a given image, will build all dependants maintained in this repositore

For example to build the singleuser image, you would run 
`./docker_build.bash -r brownccv scipy-plus-lab`

Each docker image is tagged with the git commit hash corresponding with the last git revision of the build files. A `NAMED_TAG` tag is also pushed, if `NAMED_TAG` is not passed as an argument, then `latest` is used. 

If build process is to be used for classes, the `NAMED_TAG` should correspond to semester, e.g., `fall-19`


## File / Folder structure

:warning: The subdirectories names are hierachical, where `-` separates dependant images. During the buidl process, dependent images are build in order. For instance, running:

`./docker_build.bash -r brownccv datasci-dlgpu`

Will build the `datasci` image first and then `datasci-dlgpu`


## Testing locally

While these images are created with our JupyterHub set up in mind, you can run them locally 

```
docker run -it -p 8888:8888 brownccv/jupyterhub-datasci-notebook:a1dee96
```


Or 

Attach a `bash` session 

```
docker run -it --entrypoint /bin/bash brownccv/jupyterhub-datasci-notebook:a1dee96
```
