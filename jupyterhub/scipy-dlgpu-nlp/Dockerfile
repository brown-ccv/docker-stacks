FROM browndatasci/jupyterhub-scipy-dl-gpu:963a754

MAINTAINER Jupyter Help <jupyter-help@brown.edu>

USER root

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g

# *********************Python NLP libraries ***************************
# Woosh
# NLTK
# Pytorch
RUN conda install --quiet --yes \
    'whoosh=2.7.4' \
    'nltk=3.3.*' \
    'spacy=2.0.18' &&\
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install PyText - at os 2019.1.10 there is no conda recipe 
RUN pip install pytext-nlp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER