
ARG NAMED_TAG=latest
FROM brownccv/jupyterhub-datasci:$NAMED_TAG
ARG NAMED_TAG
RUN echo "--------Pulling from brownccv/jupyterhub-datasci with tag: ${NAMED_TAG}---------"

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
    feather-format

#plotly and plotly-dash
RUN conda install -c conda-forge dash dash-renderer dash-html-components dash-core-components plotly
RUN jupyter labextension install plotlywidget
RUN jupyter labextension install jupyterlab-plotly

#sswatson voayger-launch
RUN pip install git+https://github.com/sswatson/voyager-launch plotly_express
RUN pip install jupyterlab-dash
# *********************Extensions ***************************

RUN jupyter labextension install jupyterlab-dash@0.1.0-alpha.3
RUN jupyter nbextension install jupytext --py --sys-prefix
RUN jupyter nbextension enable jupytext --py --sys-prefix
# *********************R Extras ***************************
# R packages including IRKernel which gets installed globally.
RUN conda install --quiet --yes \
    'r-ggrepel' \
    'r-maps' \
    'r-feather' \
    'r-esquisse' \
    'r-knitr' \
    'r-leaflet' \
    'r-gridextra'

# *********************Later Extensions ***************************

RUN pip install jupyterlab_latex && \
    jupyter serverextension enable --sys-prefix jupyterlab_latex && \
    jupyter labextension install @jupyterlab/latex


# Install Noto Sans Mono and TeX Gyre Pagella fonts on the system
# USER root
# RUN cd /usr/local/share/fonts && \
#     wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bold.otf && \
#     wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bolditalic.otf && \
#     wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-italic.otf && \
#     wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-regular.otf 
USER root
RUN cd /usr/share/fonts && \
    wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bold.otf && \
    wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-bolditalic.otf && \
    wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-italic.otf && \
    wget http://mirrors.ctan.org/fonts/tex-gyre/opentype/texgyrepagella-regular.otf && \
    wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSansMono-unhinted.zip && \
    unzip NotoSansMono-unhinted.zip && \
    chmod +r -R /usr/share/fonts


# RUN fc-cache -f -v 
# RUN mktexlsr

# RUN cd /usr/local/share/texmf && \
#     wget http://mirrors.ctan.org/install/fonts/noto.tds.zip 

# RUN cd /usr/local/share/texmf && unzip -o noto.tds.zip
    
# RUN cd /usr/share/fonts/truetype &&  mkdir noto && cd noto && \
#     wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSansMono-unhinted.zip && \
#     unzip NotoSansMono-unhinted.zip 
    
RUN fc-cache -fsv 
RUN mktexlsr
# RUN updmap-sys --force --enable Map=noto.map

USER $NB_UID

# Overwrite default latex/jupyter template to include above fonts    
RUN rm /opt/conda/lib/python3.7/site-packages/nbconvert/templates/latex/style_jupyter.tplx
COPY ./misc_files/data_style_jupyter.tplx /opt/conda/lib/python3.7/site-packages/nbconvert/templates/latex/style_jupyter.tplx

# RUN rm -rf /home/jovyan/.fonts/
# Clean up and fix permissions
# RUN npm cache clean --force && \
#     rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
#     rm -rf /home/$NB_USER/.cache/yarn && \
#     rm -rf /home/$NB_USER/.node-gyp && \
#     conda clean --all -f -y && \
#     fix-permissions $CONDA_DIR && \
#     fix-permissions /home/$NB_USER
