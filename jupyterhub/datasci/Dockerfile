FROM jupyter/datascience-notebook:2ce7c06a61a1

MAINTAINER Jupyter Help <jupyter-help@brown.edu>


USER root

# Install missing tools
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
    && apt-get install -yq --no-install-recommends \
    openssh-client \
    vim \
    && apt-get clean

#Install ssh-keyreg
RUN curl https://raw.githubusercontent.com/b4b4r07/ssh-keyreg/master/bin/ssh-keyreg -o /usr/local/bin/ssh-keyreg
RUN chmod +x /usr/local/bin/ssh-keyreg

# Add gitconfig script
COPY ./scripts/gitconfig /usr/local/bin/gitconfig
RUN chmod +x /usr/local/bin/gitconfig

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g


# *********************Julia Packages ***************************
RUN ls ~

RUN mkdir /home/$NB_USER/scripts

RUN ls ~


# Add packages, they are all split into different files/steps so Docker Caching can work better
COPY ./julia_scripts/install_packages.jl /home/$NB_USER/scripts/
COPY ./julia_scripts/base_pkgs.jl /home/$NB_USER/scripts/
RUN julia -e 'include(expanduser("~/scripts/install_packages.jl")); include(expanduser("~/scripts/base_pkgs.jl")); install(base_pkgs)'

COPY ./julia_scripts/plotting_pkgs.jl /home/$NB_USER/scripts/
RUN julia -e 'include(expanduser("~/scripts/install_packages.jl")); include(expanduser("~/scripts/plotting_pkgs.jl")); install(plotting_pkgs)'

COPY ./julia_scripts/datasci_pkgs.jl /home/$NB_USER/scripts/
RUN julia -e 'using Pkg; include(expanduser("~/scripts/install_packages.jl")); include(expanduser("~/scripts/datasci_pkgs.jl")); Pkg.update(); install(datasci_pkgs)'

RUN rm -rf ~/scripts

# This allows precompilation to be remembered?
ENV JULIA_DEPOT_PATH="$HOME/.julia:$JULIA_DEPOT_PATH"

# *********************Python Extras ***************************


#altair https://altair-viz.github.io
RUN conda install -c conda-forge \
    altair \
    vega_datasets \
    xgboost \
    lime \
    feather-format &&\
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

#plotly and plotly-dash
RUN conda install -c conda-forge dash dash-renderer dash-html-components dash-core-components plotly  &&\
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

#sswatson voayger-launch
RUN pip install git+https://github.com/sswatson/voyager-launch plotly_express


# *********************R Extras ***************************
# R packages including IRKernel which gets installed globally.
RUN conda install --quiet --yes \
    'r-ggrepel' \
    'r-maps' \
    'r-feather' \
    'r-esquisse' \
    'r-knitr' \
    'r-leaflet' \
    'r-gridextra' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


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
RUN jupyter lab build
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
