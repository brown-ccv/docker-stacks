FROM gcr.io/jupyterhub-docker-images/jupyterhub-scipy:06b2054

MAINTAINER Jupyter Help <jupyter-help@brown.edu>

USER root

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g

# *********************Python Deep learning, NLTK libraries ***************************
# Tensorflow
# Keras
# NLTK
# imbalanced-learn
RUN conda install --quiet --yes \
    'tensorflow=1.12.*'\
    'keras=2.2.*' \
    'imbalanced-learn=0.5.*' \
    'nltk=3.3.*' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
