FROM gcr.io/jupyterhub-docker-images/jupyterhub-scipy:spring2020

MAINTAINER Jupyter Help <jupyter-help@brown.edu>


# ********************* Additional Packages for APMA0350 ***************************
# uninstall Matplotlib extenstions
RUN ls /opt/conda/share/jupyter/lab/extensions/
RUN jupyter labextension uninstall jupyter-matplotlib@0.5.0

# ipympl
RUN conda install --quiet --yes -c conda-forge\
    ipympl && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN ls /opt/conda/share/jupyter/lab/extensions/

RUN jupyter lab build
USER $NB_UID
