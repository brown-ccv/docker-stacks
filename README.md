# Docker Stacks
Home of docker/singularity containers managed by the Data Science Practice

We based many of our containers on [jupyter docker-stack](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#core-stacks)


Getting Started
-------

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
`./docker_build.bash -r browndatasci scipy-plus-lab`

Each docker image is tagged with the git commit hash corresponding with the last git revision of the build files. 


File / Folder structure
-------

The subdirectories contain the Dockerfiles and scripts for the images used for
this deployment.