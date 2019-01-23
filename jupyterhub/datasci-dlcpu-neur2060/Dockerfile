FROM browndatasci/jupyterhub-datasci-dlcpu:latest

USER root

# Install MS core fonts as root
RUN apt-get install msttcorefonts

RUN apt-get update && apt-get -yq dist-upgrade \
    && apt-get install -yq --no-install-recommends \
    msttcorefonts \
    && apt-get clean


USER $NB_UID

#add extra plugins
RUN pip install --upgrade pip
RUN npm i npm@latest -g

# bqplot https://github.com/bloomberg/bqplot
RUN conda install -c conda-forge bqplot
RUN jupyter labextension install bqplot

#qgrid https://github.com/quantopian/qgrid 
RUN conda install -c conda-forge qgrid
RUN jupyter labextension install qgrid

#altair https://altair-viz.github.io
RUN conda install -c conda-forge altair vega_datasets

#holoviews http://holoviews.org/s
RUN conda install -c pyviz holoviews
RUN jupyter labextension install @pyviz/jupyterlab_pyviz

# Clean up and fix permissions    
RUN rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

