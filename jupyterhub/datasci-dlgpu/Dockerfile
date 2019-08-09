FROM brownccv/jupyterhub-datasci:latest

MAINTAINER Jupyter Help <jupyter-help@brown.edu>


USER root

USER $NB_UID


RUN pip install --upgrade pip
RUN npm i npm@latest -g

# *********************Python Deep learning libraries ***************************
# Pytorch
RUN conda install --quiet --yes \
    'pytorch=1.0.*' 'torchvision=0.2.*' -c pytorch && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Tensorflow
# Keras
RUN conda install --quiet --yes \
    'tensorflow-gpu=1.12.*'\
    'keras-gpu=2.2.*' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER