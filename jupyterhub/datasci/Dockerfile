FROM jupyter/datascience-notebook:latest

MAINTAINER Jupyter Help <jupyter-help@brown.edu>


USER root

# Install missing systems (apt-get) tools
COPY ./scripts/install_sys_deps.sh /tmp/install_sys_deps.sh
RUN chmod +x /tmp/install_sys_deps.sh
RUN /tmp/install_sys_deps.sh

#Install ssh-keyreg
RUN curl https://raw.githubusercontent.com/b4b4r07/ssh-keyreg/master/bin/ssh-keyreg -o /usr/local/bin/ssh-keyreg
RUN chmod +x /usr/local/bin/ssh-keyreg

# Add gitconfig script
COPY ./scripts/gitconfig /usr/local/bin/gitconfig
RUN chmod +x /usr/local/bin/gitconfig

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g


# ********************* Julia ***************************
# This allows precompilation to be remembered?
ENV JULIA_DEPOT_PATH="$HOME/.julia:$JULIA_DEPOT_PATH"

# *********************Extensions ***************************

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

#Install VS Code
RUN pip install jupyter-server-proxy
RUN jupyter serverextension enable --sys-prefix --py jupyter_server_proxy
# RUN  jupyter labextension install jupyterlab-server-proxy && \
RUN cd /tmp/ && \
    git clone --depth 1 https://github.com/jupyterhub/jupyter-server-proxy && \
    cd jupyter-server-proxy/jupyterlab-server-proxy && \
    npm install && npm run build && jupyter labextension link . && \
    npm run build && jupyter lab build

#Install VSCode Proxy
RUN pip install git+https://github.com/betatim/vscode-binder

# Download and install VS Code server
USER root
RUN wget https://github.com/cdr/code-server/releases/download/1.1119-vsc1.33.1/code-server1.1119-vsc1.33.1-linux-x64.tar.gz
RUN tar xzf code-server1.1119-vsc1.33.1-linux-x64.tar.gz
RUN mv code-server1.1119-vsc1.33.1-linux-x64/code-server /usr/local/bin/
RUN rm code-server1.1119-vsc1.33.1-linux-x64.tar.gz
RUN rm -rf code-server1.1119-vsc1.33.1-linux-x64


# Clean up and fix permissions
RUN rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
