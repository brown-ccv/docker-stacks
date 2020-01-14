FROM gcr.io/jupyterhub-docker-images/jupyterhub-datasci:spring2020

MAINTAINER Jupyter Help <jupyter-help@brown.edu>

# ********************* Install MS core fonts as root ***************************

USER root

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" && \
    apt-get install -y cabextract xfonts-utils

RUN wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.7_all.deb
RUN dpkg -i ttf-mscorefonts-installer_3.7_all.deb
RUN fc-cache -f -v

RUN apt-get clean

USER $NB_UID
RUN conda update conda

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
    'keras=2.3.*' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# *********************Python Extras ***************************
RUN conda install --quiet --yes \
    'bokeh' \
    'bqplot' \
    'qgrid' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN pip install 'pyviz' \
    'holoviews[recommended]'

RUN jupyter labextension install bqplot
RUN jupyter labextension install qgrid
RUN jupyter labextension install @pyviz/jupyterlab_pyviz

# Clean up and fix permissions
RUN rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
