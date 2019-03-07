FROM jupyter/datascience-notebook:7f1482f5a136

MAINTAINER Jupyter Help <jupyter-help@brown.edu>


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

# Install google-drive extension
RUN jupyter labextension install @jupyterlab/google-drive

# Install nbgitpuller extension
RUN pip install nbgitpuller && \
    jupyter serverextension enable --py nbgitpuller --sys-prefix && \
    npm cache clean --force

# Install RISE extension
RUN pip install RISE && \
    jupyter nbextension install rise --py --sys-prefix &&\
    jupyter nbextension enable rise --py --sys-prefix &&\
    npm cache clean --force

# RUN jupyter labextension install @jupyterlab/git && \
#     pip install jupyterlab-git && \
#     jupyter serverextension enable --py jupyterlab_git &&\
#     npm cache clean --force

# Clean up and fix permissions    
RUN rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

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

#what about python packages?

# This allows precompilation to be remembered?
ENV JULIA_DEPOT_PATH="$HOME/.julia:$JULIA_DEPOT_PATH"

# *********************Python Extras ***************************

# update python numpy matplotlib pandas bokeh (jupyter-scipy are a bit old)
RUN conda update python numpy matplotlib pandas bokeh

#altair https://altair-viz.github.io
RUN conda install -c conda-forge altair vega_datasets &&\
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# *********************R Extras ***************************
# R packages including IRKernel which gets installed globally.
RUN conda install --quiet --yes \
    'r-ggrepel' \
    'r-maps' \
    'r-gridextra' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

