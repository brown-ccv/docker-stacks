# BCBC Base Container


* Julia Base + Basic Python + Basic R

For example to build the image, run 
`./docker_build.bash -r bcbi bcbi_base`

To run the docker container
`docker run --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "$PWD":/home/jovyan/work bcbi/jupyterhub-bcbi_base:24bb450`

docker run -p 8888:8888 bcbi/bcbi_base:24bb450

docker run -p 8888:8888 jupyter/datascience-notebook:14fdfbf9cfc1

http://127.0.0.1:8888/tree?

docker run bcbi/bcbi_base:24bb450