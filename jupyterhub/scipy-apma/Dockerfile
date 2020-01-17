FROM gcr.io/jupyterhub-docker-images/jupyterhub-scipy:spring2020

MAINTAINER Jupyter Help <jupyter-help@brown.edu>


# ********************* Additional Packages for APMA0350 ***************************
# uninstall Matplotlib extenstions
RUN jupyter labextension uninstall jupyter-matplotlib@0.4.0
RUN jupyter labextension uninstall jupyter-matplotlib@0.4.1
RUN jupyter labextension install jupyter-matplotlib@0.5.0


RUN jupyter lab build
USER $NB_UID
