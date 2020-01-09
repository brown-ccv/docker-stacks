FROM jupyter/datascience-notebook:7a0c7325e470

MAINTAINER Jupyter Help <jupyter-help@brown.edu>

USER root

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		libapparmor1 \
		libedit2 \
		lsb-release \
		psmisc \
		libssl1.0.0 \
		gdebi-core

# Install missing systems (apt-get) tools
COPY ./scripts/install_sys_deps.sh /tmp/install_sys_deps.sh
RUN chmod +x /tmp/install_sys_deps.sh
RUN /tmp/install_sys_deps.sh

####### ************ Install Node.js 12.4 ************ #########
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

####### *********** END Installing Node.js 12.4 *************** #########

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
RUN conda update jupyterlab


# # ********************* Julia ***************************
# This allows precompilation to be remembered?
ENV JULIA_DEPOT_PATH="$HOME/.julia:$JULIA_DEPOT_PATH"

# *********************Python Extras ***************************
#altair https://altair-viz.github.io
RUN conda install -c conda-forge \
    'altair' \
    'vega_datasets' \
    'xgboost' \
    'lime' \
    'jupytext' \
    'feather-format' \
    'plotnine'

# *********************R Extras ***************************
# R packages including IRKernel which gets installed globally.
RUN conda install --quiet --yes \
    'r-ggrepel' \
    'r-maps' \
    'r-feather' \
    'r-esquisse' \
    'r-knitr' \
    'r-leaflet' \
    'r-gridextra' \
    'r-mlr'


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

RUN pip install --upgrade nbdime &&\
    nbdime extensions --enable --sys-prefix &&\
    jupyter labextension install @jupyterlab/git && \
    pip install --upgrade jupyterlab-git && \
    jupyter serverextension enable --py jupyterlab_git --sys-prefix && \
    npm cache clean --force

# Install JupyterLab extensions
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install jupyter-matplotlib

RUN jupyter lab build

# ************** VSCode ********************
#Install VS Code
RUN pip install jupyter-server-proxy
RUN jupyter serverextension enable --sys-prefix --py jupyter_server_proxy
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
RUN wget https://github.com/cdr/code-server/releases/download/2.1692-vsc1.39.2/code-server2.1692-vsc1.39.2-linux-x86_64.tar.gz
RUN tar xzf code-server2.1692-vsc1.39.2-linux-x86_64.tar.gz
RUN mv code-server2.1692-vsc1.39.2-linux-x86_64/code-server /usr/local/bin/
RUN rm code-server2.1692-vsc1.39.2-linux-x86_64.tar.gz
RUN rm -rf code-server2.1692-vsc1.39.2-linux-x86_64


# ************** RStudio ********************

# Official R-Studio 1.2 release
ENV RSTUDIO_VERSION 1.2.5033
RUN wget https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-${RSTUDIO_VERSION}-amd64.deb \
  && gdebi -n rstudio-server-${RSTUDIO_VERSION}-amd64.deb \
  && rm rstudio-server-*-amd64.deb

# link to Rstudio's pandoc
RUN ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin/pandoc

USER $NB_UID

RUN pip install git+https://github.com/jupyterhub/jupyter-rsession-proxy@master
# The desktop package uses /usr/lib/rstudio/bin
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
ENV LD_LIBRARY_PATH="/usr/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server:/opt/conda/lib/R/lib"

# ************** Fix latex/pdf export for nbconvert see -  https://github.com/jupyter/nbconvert/issues/786 ********************


# # Install missing fonts
# USER root
# RUN cd /usr/share/fonts && \
#     wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bold.otf && \
#     wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bolditalic.otf && \
#     wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-italic.otf && \
#     wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-regular.otf && \
#     wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSansMono-unhinted.zip && \
#     unzip NotoSansMono-unhinted.zip && \
#     chmod +r -R /usr/share/fonts
#
# RUN fc-cache -fsv
# RUN mktexlsr
#
#
# # Overwrite default latex/jupyter template to include above fonts
# RUN rm /opt/conda/lib/python3.7/site-packages/nbconvert/templates/latex/style_jupyter.tplx
# COPY ./misc_files/data_style_jupyter2.tplx /opt/conda/lib/python3.7/site-packages/nbconvert/templates/latex/style_jupyter.tplx
