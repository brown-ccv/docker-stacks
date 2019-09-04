FROM jupyter/datascience-notebook:latest

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
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager 
RUN jupyter labextension install jupyter-matplotlib 
# RUN jupyter labextension install @jupyterlab/plotly-extension 
RUN jupyter labextension install @jupyterlab/geojson-extension 
# RUN jupyter labextension install @jupyterlab/mathjax3-extension 
# RUN jupyter labextension install @jupyterlab/katex-extension

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

# ************** RStudio ********************

# Official R-Studio 1.2 release
ENV RSTUDIO_VERSION 1.2.1541
RUN wget https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-${RSTUDIO_VERSION}-amd64.deb \
  && gdebi -n rstudio-server-${RSTUDIO_VERSION}-amd64.deb \
  && rm rstudio-server-*-amd64.deb

# link to Rstudio's pandoc
RUN ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin/pandoc

# Shiny
ENV SHINY_VERSION 1.5.9.923

RUN wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-${SHINY_VERSION}-amd64.deb \
  && gdebi -n shiny-server-${SHINY_VERSION}-amd64.deb \
  && rm shiny-server-*-amd64.deb

USER $NB_USER

RUN pip install git+https://github.com/jupyterhub/jupyter-rsession-proxy@master

# The desktop package uses /usr/lib/rstudio/bin
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
ENV LD_LIBRARY_PATH="/usr/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server:/opt/conda/lib/R/lib"

# ************** Fix latex/pdf export for nbconvert see -  https://github.com/jupyter/nbconvert/issues/786 ********************

# # Install missing fonts
USER root
RUN cd /usr/share/fonts && \
    wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bold.otf && \
    wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bolditalic.otf && \
    wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-italic.otf && \
    wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-regular.otf && \
    wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSansMono-unhinted.zip && \
    unzip NotoSansMono-unhinted.zip && \
    chmod +r -R /usr/share/fonts
    
RUN fc-cache -fsv 
RUN mktexlsr

USER $NB_UID

# Overwrite default latex/jupyter template to include above fonts    
RUN rm /opt/conda/lib/python3.7/site-packages/nbconvert/templates/latex/style_jupyter.tplx
COPY ./misc_files/data_style_jupyter.tplx /opt/conda/lib/python3.7/site-packages/nbconvert/templates/latex/style_jupyter.tplx

RUN rm -rf /home/jovyan/.fonts/
# Clean up and fix permissions
RUN npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER