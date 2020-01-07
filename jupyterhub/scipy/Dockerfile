FROM jupyter/scipy-notebook:latest

USER root

# Install missing systems (apt-get) tools
COPY ./scripts/install_sys_deps.sh /tmp/install_sys_deps.sh
RUN chmod +x /tmp/install_sys_deps.sh
RUN /tmp/install_sys_deps.sh

####### Install Node.js 12.4 #########
USER $NB_UID

# nvm environment variables
RUN mkdir /home/jovyan/.nvm
ENV NVM_DIR /home/jovyan/.nvm
ENV NODE_VERSION 12.4.0

# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
RUN [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
RUN chmod -R 775 $NVM_DIR

# install node and npm
RUN $NVM_DIR/nvm.sh install $NODE_VERSION
RUN $NVM_DIR/nvm.sh alias default $NODE_VERSION
RUN $NVM_DIR/nvm.sh use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

####### END Installing Node.js 12.4 #########

USER root
#Install ssh-keyreg
RUN curl https://raw.githubusercontent.com/b4b4r07/ssh-keyreg/master/bin/ssh-keyreg -o /usr/local/bin/ssh-keyreg
RUN chmod +x /usr/local/bin/ssh-keyreg

# Add gitconfig script
COPY ./scripts/gitconfig /usr/local/bin/gitconfig
RUN chmod +x /usr/local/bin/gitconfig

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g


# Install Git extension
RUN jupyter labextension install @jupyterlab/git && \
    pip install --upgrade jupyterlab-git && \
    jupyter serverextension enable --py jupyterlab_git

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
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager 
RUN jupyter labextension install jupyter-matplotlib
RUN jupyter labextension install jupyterlab-plotly
RUN jupyter labextension install @jupyterlab/geojson-extension
RUN jupyter labextension install @jupyterlab/mathjax3-extension
RUN jupyter labextension install @jupyterlab/katex-extension

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

# Clean up and fix permissions
RUN rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Download and install VS Code server
USER root
RUN wget https://github.com/cdr/code-server/releases/download/1.1119-vsc1.33.1/code-server1.1119-vsc1.33.1-linux-x64.tar.gz
RUN tar xzf code-server1.1119-vsc1.33.1-linux-x64.tar.gz
RUN mv code-server1.1119-vsc1.33.1-linux-x64/code-server /usr/local/bin/
RUN rm code-server1.1119-vsc1.33.1-linux-x64.tar.gz
RUN rm -rf code-server1.1119-vsc1.33.1-linux-x64
