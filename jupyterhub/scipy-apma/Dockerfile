FROM gcr.io/jupyterhub-docker-images/jupyterhub-scipy:spring2020

MAINTAINER Jupyter Help <jupyter-help@brown.edu>


# ********************* Additional Packages for APMA0350 ***************************
# uninstall Matplotlib extenstions
RUN ls /opt/conda/share/jupyter/lab/extensions/
RUN jupyter labextension list
# ipympl
RUN conda install --quiet --yes -c conda-forge\
    ipympl && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN npm install --save jupyter-matplotlib@0.4.1

RUN ls /opt/conda/share/jupyter/lab/extensions/

RUN rm /opt/conda/share/jupyter/lab/extensions/jupyter-matplotlib-0.4.0.tgz
RUN ls /opt/conda/share/jupyter/lab/extensions/

RUN jupyter lab build

RUN jupyter labextension list

USER $NB_UID
