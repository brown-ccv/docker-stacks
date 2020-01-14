FROM gcr.io/jupyterhub-docker-images/jupyterhub-scipy:spring2020

MAINTAINER Jupyter Help <jupyter-help@brown.edu>

USER root

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g

# *********************Python Deep learning libraries ***************************
# Pytorch
RUN conda install --quiet --yes \
    'pytorch-cpu=1.2.*' 'torchvision-cpu=0.3.*' -c pytorch && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Tensorflow
# Keras
# imbalanced-learn
RUN conda install --quiet --yes \
    'scikit-learn=0.22.*' \
    'tensorflow=2.0.*'\
    'keras=2.3.*' \
    'imbalanced-learn=0.6.*' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Woosh
# NLTK
# Pytorch
RUN conda install --quiet --yes \
    'whoosh=2.7.4' \
    'nltk=3.4.*' \
    'spacy=2.2.3' &&\
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install PyText - at os 2019.1.10 there is no conda recipe
RUN pip install 'pytext-nlp' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
