FROM gcr.io/jupyterhub-docker-images/jupyterhub-scipy:spring2020

MAINTAINER Jupyter Help <jupyter-help@brown.edu>


# ********************* Additional Packages for APMA0350 ***************************
# uninstall Matplotlib extenstions
RUN ls /opt/conda/share/jupyter/lab/extensions/
RUN jupyter labextension uninstall jupyter-matplotlib

RUN jupyter labextension install jupyter-matplotlib@0.5.0
RUN ls /opt/conda/share/jupyter/lab/extensions/

RUN jupyter lab build
USER $NB_UID
