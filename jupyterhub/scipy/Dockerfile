FROM jupyter/scipy-notebook:7a3e968dd212

USER root

# Install missing tools
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
    && apt-get install -yq --no-install-recommends \
    openssh-client \
    vim \ 
    && apt-get clean

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g

# *********************Extensions ***************************

# Install google-drive extension -
# RUN jupyter labextension install @jupyterlab/google-drive

# Install nbgitpuller extension
RUN pip install nbgitpuller && \
    jupyter serverextension enable --py nbgitpuller --sys-prefix && \
    npm cache clean --force

# Install RISE extension
RUN pip install RISE && \
    jupyter nbextension install rise --py --sys-prefix &&\
    jupyter nbextension enable rise --py --sys-prefix &&\
    npm cache clean --force

RUN jupyter labextension install @jupyterlab/git && \
    pip install --upgrade jupyterlab-git && \
    jupyter serverextension enable --py jupyterlab_git --sys-prefix &&\
    npm cache clean --force

# Install JupyterLab extensions
RUN jupyter labextension install \
            @jupyterlab/vega2-extension \
            @jupyterlab/vega3-extension \
            @jupyter-widgets/jupyterlab-manager \
            jupyter-matplotlib \
            @jupyterlab/plotly-extension \
            @jupyterlab/geojson-extension \
            @jupyterlab/mathjax3-extension \
            @jupyterlab/katex-extension

# Clean up and fix permissions    
RUN rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

