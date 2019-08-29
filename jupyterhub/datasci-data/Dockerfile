FROM brownccv/jupyterhub-datasci:latest

MAINTAINER Jupyter Help <jupyter-help@brown.edu>

USER $NB_UID

# *********************Julia Packages ***************************

# Add packages, they are all split into different files/steps so Docker Caching can work better
COPY ./julia_scripts/install_packages.jl /tmp
COPY ./julia_scripts/julia_pkgs.jl /tmp
RUN julia -e 'include(expanduser("/tmp/install_packages.jl")); include(expanduser("/tmp/julia_pkgs.jl")); install(plotting_pkgs); install(external_pkgs); install(dataset_pkgs); install(other_pkgs)'

# *********************Python Extras ***************************

#altair https://altair-viz.github.io
RUN conda install -c conda-forge \
    altair \
    vega_datasets \
    xgboost \
    lime \
    jupytext \
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
RUN pip install jupyterlab-dash
# *********************Extensions ***************************

RUN jupyter labextension install jupyterlab-dash@0.1.0-alpha.3
USER root
RUN jupyter nbextension install --py jupytext
USER $NB_UID

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

# Clean up and fix permissions
RUN rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# ************** Fix latex/pdf export for nbconvert see -  https://github.com/jupyter/nbconvert/issues/786 ********************
RUN rm /opt/conda/lib/python3.7/site-packages/nbconvert/templates/latex/style_jupyter.tplx
COPY ./misc_files/style_jupyter.tplx /opt/conda/lib/python3.7/site-packages/nbconvert/templates/latex/style_jupyter.tplx
