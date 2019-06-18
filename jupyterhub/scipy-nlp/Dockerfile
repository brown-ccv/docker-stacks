FROM brownccv/jupyterhub-scipy:latest

MAINTAINER Jupyter Help <jupyter-help@brown.edu>

USER root

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g


# *********************Python NLP libraries ***************************
RUN pip install plotly nltk && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
