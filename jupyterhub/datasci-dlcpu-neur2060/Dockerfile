FROM brownccv/jupyterhub-datasci-dlcpu:latest

USER root

# Install MS core fonts as root
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" && \
    apt-get install -y cabextract xfonts-utils

RUN wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.7_all.deb
RUN dpkg -i ttf-mscorefonts-installer_3.7_all.deb
RUN fc-cache -f -v

RUN apt-get clean

USER $NB_UID

#add extra plugins
RUN pip install --upgrade pip
RUN npm i npm@latest -g

# update python numpy matplotlib pandas bokeh (jupyter-scipy are a bit old)
RUN conda update python numpy matplotlib pandas bokeh

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

